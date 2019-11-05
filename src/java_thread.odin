package ff4j

Java_Thread :: struct {
	interp: Interpreter
}

make_java_thread :: proc() -> ^Java_Thread {
	t := new(Java_Thread);
	init_interpreter(&t.interp);
	return t;
}

delete_thread :: proc(using t: ^Java_Thread) {
	delete_interpreter(&interp);
	free(t);
}