package fjvm

import "core:fmt"

Class_Loader :: struct {
	class_by_name: map[string]^Class
}

@private
bootstrap_class_loader :: proc(using cl: ^Class_Loader) {
	ocf, ccf: Class_File;

	if _ocf, err := load_class_file("java.lang.Object"); err == .NO_ERROR do ocf = _ocf;
	else do panic("Unable to load java.lang.Object");

	if _ccf, err := load_class_file("java.lang.Class"); err == .NO_ERROR do ccf = _ccf;
	else do panic("Unable to load java.lang.Class");

	oc := new(Class);
	oc.name = "java.lang.Object";
	oc.major = ocf.major;
	oc.minor = ocf.minor;
	oc.constant_pool = ocf.constant_pool;
	oc.access = ocf.access;
	oc.super_class = nil;
	// TODO: interfaces
	oc.fields = ocf.fields;
	oc.methods = ocf.methods;
	oc.attributes = ocf.attributes;

	cc := new(Class);
	cc.name = "java.lang.Class";
	cc.major = ccf.major;
	cc.minor = ccf.minor;
	cc.constant_pool = ccf.constant_pool;
	cc.access = ccf.access;
	cc.super_class = oc;
	// TODO: interfaces
	cc.fields = ccf.fields;
	cc.methods = ccf.methods;
	cc.attributes = ccf.attributes;

	class_by_name["java.lang.Object"] = oc;
	class_by_name["java.lang.Class"] = cc;
}

make_class_loader :: proc() -> ^Class_Loader {
	cl := new(Class_Loader);
	cl.class_by_name = make(map[string]^Class);
	bootstrap_class_loader(cl);
	return cl;
}

delete_class_loader :: proc(using cl: ^Class_Loader) {
	delete(class_by_name);
	free(cl);
}

@private
load_class_from_class_file :: proc(cl: ^Class_Loader, using cf: Class_File) -> (^Class, bool) {
	name: string;
	_super_class: ^Class;
	_interfaces := make([]^Class, len(interfaces));

	{
		class_info_entry: Constant_Class_Info;

		if _class_info_entry, ok := constant_pool[this_class].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
		else do return nil, false;

		if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok do name = string(name_entry.bytes);
		else do return nil, false;
	}

	if super_class != 0 {
		class_info_entry: Constant_Class_Info;

		if _class_info_entry, ok := constant_pool[super_class].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
		else do return nil, false;

		if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok {
			class := get_class_by_name(cl, string(name_entry.bytes));
			if class == nil do return nil, false;
			_super_class = class;
		} else do return nil, false;
	}

	for i in 0..<len(interfaces) {
		interface_index := interfaces[i];
		class_info_entry: Constant_Class_Info;

		if _class_info_entry, ok := constant_pool[interface_index].(Constant_Class_Info); ok do class_info_entry = _class_info_entry;
		else do return nil, false;

		if name_entry, ok := constant_pool[class_info_entry.name_index].(Constant_Utf8_Info); ok {
			class := get_class_by_name(cl, string(name_entry.bytes));
			if class == nil do return nil, false;
			if class.access & ACC_INTERFACE == 0 do return nil, false;
			_interfaces[i] = class;
		} else do return nil, false;
	}

	c := new(Class);
	c.name = name;
	c.major = major;
	c.minor = minor;
	c.constant_pool = constant_pool;
	c.access = access;
	c.super_class = _super_class;
	c.interfaces = _interfaces;
	c.fields = fields;
	c.methods = methods;
	c.attributes = attributes;

	// TODO: call <clinit> on c

	class_instance := make_object(cl.class_by_name["java.lang.Class"]);

	// TODO: call <cinit> on class_instance

	return c, true;
}

get_class_by_name :: proc(using cl: ^Class_Loader, name: string) -> ^Class {
	if class, ok := class_by_name[name]; ok do return class;

	class_file, err := load_class_file(name);
	if err != .NO_ERROR {
		// TODO
		return nil;
	}

	class, ok := load_class_from_class_file(cl, class_file);
	if !ok {
		// TODO
		return nil;
	}

	class_by_name[name] = class;
	return class;
}