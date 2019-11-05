package ff4j

import "core:mem"

DEFAULT_STACK_SIZE :: 1024 * 8;

Stack_Frame :: struct {

}

Interpreter :: struct {
	stack_data: []u8
	stack_allocator: mem.Stack
}

init_interpreter :: proc(using i: ^Interpreter, stack_size := DEFAULT_STACK_SIZE) {
	stack_data = make([]u8, stack_size);
	mem.init_stack(&stack_allocator, stack_data);
}

delete_interpreter :: proc(using i: ^Interpreter) {
	delete(stack_data);
}