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
	attributes: []Attribute_Info
}

make_class :: proc() -> ^Class {
	c := new(Class);
	c.method_by_name_and_descriptor = make(map[string]^Method);
	return c;
}

delete_class :: proc(using c: ^Class) {
	for _, v in method_by_name_and_descriptor do delete_method(v);
	delete(method_by_name_and_descriptor);
	free(c);
}