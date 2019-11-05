package ff4j

// TODO: we need to have an instance of java.lang.Thread for each Java_Thread

Java_Thread_State :: enum {
	NEW,
	RUNNABLE,
	BLOCKED,
	WAITING,
	TIMED_WAITING,
	TERMINATED
}

Java_Thread :: struct {
	interp: Interpreter,
	target_object: ^Object,
	start_method: ^Method
}

make_java_thread :: proc(target_object: ^Object, method: ^Method) -> ^Java_Thread {
	t := new(Java_Thread);
	t.target_object = target_object;
	t.start_method = method;
	init_interpreter(&t.interp);
	return t;
}

delete_thread :: proc(using t: ^Java_Thread) {
	delete_interpreter(&interp);
	free(t);
}