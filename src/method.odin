package fjvm

Method :: struct {
	class: ^Class,
	name: string,
	descriptor: string,
	access: u16,
	code: []u8,
	attributes: []Attribute_Info
}