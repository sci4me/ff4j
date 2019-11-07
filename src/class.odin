package ff4j

Class :: struct {
    name: string,
    major: u16,
    minor: u16,
    constant_pool: []ConstantPool_Info,
    access: u16,
    super_class: ^Class,
    interfaces: []^Class,   
    fields: []Field_Info,
    method_by_name_and_descriptor: map[string]^Method,
    attributes: []Attribute_Info,

    static_fields: map[string]^Value
}

make_class :: proc() -> ^Class {
    c := new(Class);
    c.method_by_name_and_descriptor = make(map[string]^Method);
    c.static_fields = make(map[string]^Value);
    return c;
}

delete_class :: proc(using c: ^Class) {
    for _, v in method_by_name_and_descriptor do delete_method(v);
    delete(method_by_name_and_descriptor);
    delete(static_fields);
    free(c);
}

get_cpe :: proc(using c: ^Class, idx: u16, $T: typeid) -> (T, bool) {
    if t, ok := constant_pool[idx].(T); ok {
        return t, true;
    } else {
        dummy: T;
        return dummy, false;
    }   
}

get_utf8_cpe :: proc(using c: ^Class, idx: u16) -> (string, bool) {
    if cpe, ok := get_cpe(c, idx, Constant_Utf8_Info); ok {
        return string(cpe.bytes), true;
    } else {
        return "", false;
    }
}