package ffvm

Code :: struct {
	max_stack: u16,
	max_locals: u16,
	code: []u8,
	exception_table: []Exception_Table_Entry,
	attributes: []Attribute_Info
}

make_code :: proc() -> ^Code {
	return new(Code);
}

delete_code :: proc(using c: ^Code) {
	if exception_table != nil do delete(exception_table);
	if attributes != nil do delete(attributes);
	free(c);
}

Method :: struct {
	class: ^Class,
	name: string,
	descriptor: string,
	access: u16,
	code: ^Code
}

make_method :: proc() -> ^Method {
	return new(Method);
}

delete_method :: proc(using m: ^Method) {
	if code != nil do delete_code(code);
	free(m);
}