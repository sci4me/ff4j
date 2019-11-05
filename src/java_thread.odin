package ff4j

import "core:time"

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
    start_method: ^Method,
    state: Java_Thread_State
}

make_java_thread :: proc(target_object: ^Object, method: ^Method) -> ^Java_Thread {
    t := new(Java_Thread);
    t.target_object = target_object;
    t.start_method = method;
    t.state = .NEW;
    init_interpreter(&t.interp);
    return t;
}

delete_thread :: proc(using t: ^Java_Thread) {
    delete_interpreter(&interp);
    free(t);
}

run_thread_for_ms :: proc(using t: ^Java_Thread, ms: int) {
    start := time.now();
    for time.duration_nanoseconds(time.diff(start, time.now())) < i64(ms) * 1e6 {
        execute_single_instruction(&interp);
    }
}