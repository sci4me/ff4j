package ff4j

Object :: struct {
	class: ^Class
}

make_object :: proc(class: ^Class) -> ^Object {
	o := new(Object);
	o.class = class;
	// TODO
	return o;
}

delete_object :: proc(o: ^Object) {
	free(o);
}