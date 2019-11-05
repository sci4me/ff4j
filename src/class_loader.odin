package ff4j

import "core:strings"
import "core:fmt"

Load_Error :: enum {
    NO_ERROR,
    PARSE_ERROR,
    BAD_CLASS,
    OTHER
}

Class_Loader :: struct {
    class_by_name: map[string]^Class,

    object_class: ^Class,
    object_class_instance: ^Object,
    
    class_class: ^Class,
    class_class_instance: ^Object
}

@private
load_methods :: proc(using c: ^Class, methods: []Method_Info) -> Load_Error {
    for method_info in methods {
        name, descriptor: string;
        
        if name_entry, ok := constant_pool[method_info.name_index].(Constant_Utf8_Info); ok do name = string(name_entry.bytes);
        else do return .BAD_CLASS;

        if descriptor_entry, ok := constant_pool[method_info.descriptor_index].(Constant_Utf8_Info); ok do descriptor = string(descriptor_entry.bytes);
        else do return .BAD_CLASS;      
        
        method := make_method();
        method.class = c;
        method.name = name;
        method.descriptor = descriptor;
        method.access = method_info.access;

        if method.access & (ACC_NATIVE | ACC_ABSTRACT) == 0 {
            for attr in method_info.attributes {
                if code, ok := attr.(Code_Attribute_Info); ok {
                    c := make_code();
                    c.max_stack = code.max_stack;
                    c.max_locals = code.max_locals;
                    c.code = code.code; // TODO
                    c.exception_table = code.exception_table;
                    c.attributes = code.attributes;
                    method.code = c;
                    break;
                }
            }
        }

        c.method_by_name_and_descriptor[fmt.aprintf("%s%s", method.name, method.descriptor)] = method; // TODO: leak
    }

    return .NO_ERROR;
}

@private
bootstrap_class_loader :: proc(using cl: ^Class_Loader) {
    ocf, ccf: Class_File;

    if _ocf, err := load_class_file("java.lang.Object"); err == .NO_ERROR do ocf = _ocf;
    else do panic("Unable to load java.lang.Object");

    if _ccf, err := load_class_file("java.lang.Class"); err == .NO_ERROR do ccf = _ccf;
    else do panic("Unable to load java.lang.Class");

    oc := make_class();
    oc.name = "java.lang.Object";
    oc.major = ocf.major;
    oc.minor = ocf.minor;
    oc.constant_pool = ocf.constant_pool;
    oc.access = ocf.access;
    oc.super_class = nil;
    // TODO: interfaces
    oc.fields = ocf.fields;
    load_methods(oc, ocf.methods);
    oc.attributes = ocf.attributes;

    cc := make_class();
    cc.name = "java.lang.Class";
    cc.major = ccf.major;
    cc.minor = ccf.minor;
    cc.constant_pool = ccf.constant_pool;
    cc.access = ccf.access;
    cc.super_class = oc;
    // TODO: interfaces
    cc.fields = ccf.fields;
    load_methods(cc, ccf.methods);
    cc.attributes = ccf.attributes;

    oci := make_object(oc);
    // TODO

    cci := make_object(cc);
    // TODO

    class_by_name["java.lang.Object"] = oc;
    class_by_name["java.lang.Class"] = cc;
    object_class = oc;
    object_class_instance = oci;
    class_class = cc;
    class_class_instance = cci;
}

make_class_loader :: proc() -> ^Class_Loader {
    cl := new(Class_Loader);
    cl.class_by_name = make(map[string]^Class);
    bootstrap_class_loader(cl);
    return cl;
}

delete_class_loader :: proc(using cl: ^Class_Loader) {
    for _, v in class_by_name do free(v);
    delete(class_by_name);
    free(cl);
}

@private
load_class_from_class_file :: proc(cl: ^Class_Loader, using cf: Class_File) -> (^Class, Load_Error) {
    name: string;
    _super_class: ^Class;
    _interfaces := make([]^Class, len(interfaces));

    {
        class_info_entry: Constant_Class_Info;

        if _class_info_entry, ok := constant_pool[this_class].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
        else do return nil, .BAD_CLASS;

        if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok do name = string(name_entry.bytes);
        else do return nil, .BAD_CLASS;
    }

    if super_class != 0 {
        class_info_entry: Constant_Class_Info;

        if _class_info_entry, ok := constant_pool[super_class].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
        else do return nil, .BAD_CLASS;

        if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok {
            class, err:= get_class_by_name(cl, string(name_entry.bytes));
            if err != .NO_ERROR do return nil, err;
            _super_class = class;
        } else do return nil, .BAD_CLASS;
    }

    for i in 0..<len(interfaces) {
        interface_index := interfaces[i];
        class_info_entry: Constant_Class_Info;

        if _class_info_entry, ok := constant_pool[interface_index].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
        else do return nil, .BAD_CLASS;

        if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok {
            class, err := get_class_by_name(cl, string(name_entry.bytes));
            if err != .NO_ERROR do return nil, err;
            if class.access & ACC_INTERFACE == 0 do return nil, .BAD_CLASS;
            _interfaces[i] = class;
        } else do return nil, .BAD_CLASS;
    }

    c := make_class();
    c.name = name;
    c.major = major;
    c.minor = minor;
    c.constant_pool = constant_pool;
    c.access = access;
    c.super_class = _super_class;
    c.interfaces = _interfaces;
    c.fields = fields;
    load_methods(c, methods);
    c.attributes = attributes;

    class_instance := make_object(cl.class_class);

    // TODO: call <clinit> if it exists
    // TODO: call <init>

    return c, .NO_ERROR;
}

get_class_by_name :: proc(using cl: ^Class_Loader, name: string) -> (^Class, Load_Error) {
    rname, _ := strings.replace_all(name, "/", ".", context.temp_allocator);

    if class, ok := class_by_name[rname]; ok do return class, .NO_ERROR;

    class_file: Class_File;
    class: ^Class;

    if _class_file, err := load_class_file(rname); err == .NO_ERROR do class_file = _class_file;
    else do return nil, .PARSE_ERROR;

    if _class, err := load_class_from_class_file(cl, class_file); err == .NO_ERROR do class = _class;
    else do return nil, err;

    class_by_name[rname] = class;
    return class, .NO_ERROR;
}