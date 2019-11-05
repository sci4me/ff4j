package fjvm

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