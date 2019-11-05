package ff4j

Java_Thread :: struct {
	interp: Interpreter,
	object: ^Object,
	start_method: ^Method
}

make_java_thread :: proc(object: ^Object, method: ^Method) -> ^Java_Thread {
	t := new(Java_Thread);
	t.object = object;
	t.start_method = method;
	init_interpreter(&t.interp);
	return t;
}

delete_thread :: proc(using t: ^Java_Thread) {
	delete_interpreter(&interp);
	free(t);
}