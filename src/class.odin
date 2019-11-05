package fjvm

import "core:fmt" // TODO: remove this

Class :: struct {
	name: string,
	major: u16,
	minor: u16,
	constant_pool: []ConstantPool_Info,
	access: u16,
	super_class: ^Class,
	interfaces: []^Class,	
	fields: []Field_Info,
	methods: []Method_Info,
	attributes: []Attribute_Info
}

load_class_from_class_file :: proc(cl: ^Class_Loader, using cf: Class_File) -> (^Class, bool) {
	name: string;
	_super_class: ^Class;

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

	c := new(Class);
	c.name = name;
	c.major = major;
	c.minor = minor;
	c.constant_pool = constant_pool;
	c.access = access;
	c.super_class = _super_class;

	return c, true;
}