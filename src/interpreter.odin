package ff4j

import "core:mem"
import "core:runtime"

DEFAULT_STACK_SIZE :: 1024 * 8;

Stack_Frame :: struct {
	prev: ^Stack_Frame,
	method: ^Method,
	arguments: []Value,
	locals: []Value,
	stack: []Value
}

Interpreter :: struct {
	stack_data: []u8
	stack: mem.Stack,
	stack_allocator: mem.Allocator,
	current_frame: ^Stack_Frame
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
push_stack_frame :: proc(using i: ^Interpreter, method: ^Method, argument_count: int, local_count: int, max_stack: int) {
	frame_size := size_of(Stack_Frame) + ((argument_count + local_count + max_stack) * size_of(Value));
	
	frame := cast(^Stack_Frame) mem.alloc(frame_size, mem.DEFAULT_ALIGNMENT, stack_allocator);
	frame.prev = current_frame;
	frame.method = method;

	frame_ptr := uintptr(frame);
	frame.arguments = transmute([]Value) runtime.Raw_Slice{rawptr(frame_ptr + offset_of(Stack_Frame, arguments)), argument_count};
	frame.locals = transmute([]Value) runtime.Raw_Slice{rawptr(frame_ptr + offset_of(Stack_Frame, locals)), local_count};
	frame.stack = transmute([]Value) runtime.Raw_Slice{rawptr(frame_ptr + offset_of(Stack_Frame, stack)), max_stack};

	current_frame = frame;
}

@private
pop_stack_frame :: proc(using i: ^Interpreter) {
	frame := current_frame;
	current_frame = frame.prev;

	mem.free(frame, stack_allocator);
}