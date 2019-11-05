package ff4j

import "core:mem"
import "core:runtime"

DEFAULT_STACK_SIZE :: 1024 * 8;

/*

	Stack_Frames are not actually size_of(Stack_Frame) at runtime.
	We allocate size_of(Stack_Frame) + (max_locals * size_of(Value)) + (max_stack * size_of(Value)).
	We then set `locals` and `stack` to point into the memory we allocated accordingly.

*/

Stack_Frame :: struct {
	prev: ^Stack_Frame,
	method: ^Method,
	locals: []Value,
	stack: []Value,
	return_pc: int
}

Interpreter :: struct {
	stack_data: []u8
	stack: mem.Stack,
	stack_allocator: mem.Allocator,
	current_frame: ^Stack_Frame,
	pc: int
}

init_interpreter :: proc(using i: ^Interpreter, stack_size := DEFAULT_STACK_SIZE) {
	stack_data = make([]u8, stack_size);
	mem.init_stack(&stack, stack_data);
	stack_allocator = mem.Allocator{mem.stack_allocator_proc, &stack};
}

delete_interpreter :: proc(using i: ^Interpreter) {
	delete(stack_data);
}

@private
push_stack_frame :: proc(using i: ^Interpreter, method: ^Method, return_pc := 0) {
	max_locals := int(method.code.max_locals);
	max_stack := int(method.code.max_stack);

	frame_size := size_of(Stack_Frame) + ((max_locals + max_stack) * size_of(Value));
	
	frame := cast(^Stack_Frame) mem.alloc(frame_size, mem.DEFAULT_ALIGNMENT, stack_allocator);
	frame_ptr := uintptr(frame);

	frame.prev = current_frame;
	frame.method = method;
	frame.locals = transmute([]Value) runtime.Raw_Slice{rawptr(frame_ptr + offset_of(Stack_Frame, locals)), max_locals};
	frame.stack = transmute([]Value) runtime.Raw_Slice{rawptr(frame_ptr + offset_of(Stack_Frame, stack)), max_stack};
	frame.return_pc = return_pc;

	current_frame = frame;
}

@private
pop_stack_frame :: proc(using i: ^Interpreter) {
	frame := current_frame;
	current_frame = frame.prev;

	mem.free(frame, stack_allocator);
}