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

push_stack_frame :: proc(using i: ^Interpreter, method: ^Method, return_pc: int) {
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

pop_stack_frame :: proc(using i: ^Interpreter) {
    frame := current_frame;
    current_frame = frame.prev;

    mem.free(frame, stack_allocator);
}

execute_single_instruction :: proc(using i: ^Interpreter) -> bool {
    read_u8 :: proc(using i: ^Interpreter) -> (u8, bool) {
        if pc < len(current_frame.method.code.code) {
            v := current_frame.method.code.code[pc];
            pc += 1;
            return v, true;
        } else {
            return 0, false;
        }
    }

    opcode, ok := read_u8(i);
    if !ok do return false;

    switch opcode {
        case AALOAD:            unimplemented();
        case AASTORE:           unimplemented();
        case ACONST_NULL:       unimplemented();
        case ALOAD:             unimplemented();
        case ALOAD_0:           unimplemented();
        case ALOAD_1:           unimplemented();
        case ALOAD_2:           unimplemented();
        case ALOAD_3:           unimplemented();
        case ANEWARRAY:         unimplemented();
        case ARETURN:           unimplemented();
        case ARRAYLENGTH:       unimplemented();
        case ASTORE:            unimplemented();
        case ASTORE_0:          unimplemented();
        case ASTORE_1:          unimplemented();
        case ASTORE_2:          unimplemented();
        case ASTORE_3:          unimplemented();
        case ATHROW:            unimplemented();
        case BALOAD:            unimplemented();
        case BASTORE:           unimplemented();
        case BIPUSH:            unimplemented();
        case BREAKPOINT:        unimplemented();
        case CALOAD:            unimplemented();
        case CASTORE:           unimplemented();
        case CHECKCAST:         unimplemented();
        case D2F:               unimplemented();
        case D2I:               unimplemented();
        case D2L:               unimplemented();
        case DADD:              unimplemented();
        case DALOAD:            unimplemented();
        case DASTORE:           unimplemented();
        case DCMPG:             unimplemented();
        case DCMPL:             unimplemented();
        case DCONST_0:          unimplemented();
        case DCONST_1:          unimplemented();
        case DDIV:              unimplemented();
        case DLOAD:             unimplemented();
        case DLOAD_0:           unimplemented();
        case DLOAD_1:           unimplemented();
        case DLOAD_2:           unimplemented();
        case DLOAD_3:           unimplemented();
        case DMUL:              unimplemented();
        case DNEG:              unimplemented();
        case DREM:              unimplemented();
        case DRETURN:           unimplemented();
        case DSTORE:            unimplemented();
        case DSTORE_0:          unimplemented();
        case DSTORE_1:          unimplemented();
        case DSTORE_2:          unimplemented();
        case DSTORE_3:          unimplemented();
        case DSUB:              unimplemented();
        case DUP:               unimplemented();
        case DUP_X1:            unimplemented();
        case DUP_X2:            unimplemented();
        case DUP2:              unimplemented();
        case DUP2_X1:           unimplemented();
        case DUP2_X2:           unimplemented();
        case F2D:               unimplemented();
        case F2I:               unimplemented();
        case F2L:               unimplemented();
        case FADD:              unimplemented();
        case FALOAD:            unimplemented();
        case FASTORE:           unimplemented();
        case FCMPG:             unimplemented();
        case FCMPL:             unimplemented();
        case FCONST_0:          unimplemented();
        case FCONST_1:          unimplemented();
        case FCONST_2:          unimplemented();
        case FDIV:              unimplemented();
        case FLOAD:             unimplemented();
        case FLOAD_0:           unimplemented();
        case FLOAD_1:           unimplemented();
        case FLOAD_2:           unimplemented();
        case FLOAD_3:           unimplemented();
        case FMUL:              unimplemented();
        case FNEG:              unimplemented();
        case FREM:              unimplemented();
        case FRETURN:           unimplemented();
        case FSTORE:            unimplemented();
        case FSTORE_0:          unimplemented();
        case FSTORE_1:          unimplemented();
        case FSTORE_2:          unimplemented();
        case FSTORE_3:          unimplemented();
        case FSUB:              unimplemented();
        case GETFIELD:          unimplemented();
        case GETSTATIC:         unimplemented();
        case GOTO:              unimplemented();
        case GOTO_W:            unimplemented();
        case I2B:               unimplemented();
        case I2C:               unimplemented();
        case I2D:               unimplemented();
        case I2F:               unimplemented();
        case I2L:               unimplemented();
        case I2S:               unimplemented();
        case IADD:              unimplemented();
        case IALOAD:            unimplemented();
        case IAND:              unimplemented();
        case IASTORE:           unimplemented();
        case ICONST_M1:         unimplemented();
        case ICONST_0:          unimplemented();
        case ICONST_1:          unimplemented();
        case ICONST_2:          unimplemented();
        case ICONST_3:          unimplemented();
        case ICONST_4:          unimplemented();
        case ICONST_5:          unimplemented();
        case IF_ACMPEQ:         unimplemented();
        case IF_ACMPNE:         unimplemented();
        case IF_ICMPEQ:         unimplemented();
        case IF_ICMPGE:         unimplemented();
        case IF_ICMPGT:         unimplemented();
        case IF_ICMPLE:         unimplemented();
        case IF_ICMPLT:         unimplemented();
        case IF_ICMPNE:         unimplemented();
        case IFEQ:              unimplemented();
        case IFGE:              unimplemented();
        case IFGT:              unimplemented();
        case IFLE:              unimplemented();
        case IFLT:              unimplemented();
        case IFNE:              unimplemented();
        case IFNONNULL:         unimplemented();
        case IFNULL:            unimplemented();
        case IINC:              unimplemented();
        case ILOAD:             unimplemented();
        case ILOAD_0:           unimplemented();
        case ILOAD_1:           unimplemented();
        case ILOAD_2:           unimplemented();
        case ILOAD_3:           unimplemented();
        case IMPDEP1:           unimplemented();
        case IMPDEP2:           unimplemented();
        case IMUL:              unimplemented();
        case INEG:              unimplemented();
        case INSTANCEOF:        unimplemented();
        case INVOKEDYNAMIC:     unimplemented();
        case INVOKEINTERFACE:   unimplemented();
        case INVOKESPECIAL:     unimplemented();
        case INVOKESTATIC:      unimplemented();
        case INVOKEVIRTUAL:     unimplemented();
        case IOR:               unimplemented();
        case IREM:              unimplemented();
        case IRETURN:           unimplemented();
        case ISHL:              unimplemented();
        case ISHR:              unimplemented();
        case ISTORE:            unimplemented();
        case ISTORE_0:          unimplemented();
        case ISTORE_1:          unimplemented();
        case ISTORE_2:          unimplemented();
        case ISTORE_3:          unimplemented();
        case ISUB:              unimplemented();
        case IUSHR:             unimplemented();
        case IXOR:              unimplemented();
        case JSR:               unimplemented();
        case JSR_W:             unimplemented();
        case L2D:               unimplemented();
        case L2F:               unimplemented();
        case L2I:               unimplemented();
        case LADD:              unimplemented();
        case LALOAD:            unimplemented();
        case LAND:              unimplemented();
        case LASTORE:           unimplemented();
        case LCMP:              unimplemented();
        case LCONST_0:          unimplemented();
        case LCONST_1:          unimplemented();
        case LDC:               unimplemented();
        case LDC_W:             unimplemented();
        case LDC2_W:            unimplemented();
        case LDIV:              unimplemented();
        case LLOAD:             unimplemented();
        case LLOAD_0:           unimplemented();
        case LLOAD_1:           unimplemented();
        case LLOAD_2:           unimplemented();
        case LLOAD_3:           unimplemented();
        case LMUL:              unimplemented();
        case LNEG:              unimplemented();
        case LOOKUPSWITCH:      unimplemented();
        case LOR:               unimplemented();
        case LREM:              unimplemented();
        case LRETURN:           unimplemented();
        case LSHL:              unimplemented();
        case LSHR:              unimplemented();
        case LSTORE:            unimplemented();
        case LSTORE_0:          unimplemented();
        case LSTORE_1:          unimplemented();
        case LSTORE_2:          unimplemented();
        case LSTORE_3:          unimplemented();
        case LSUB:              unimplemented();
        case LUSHR:             unimplemented();
        case LXOR:              unimplemented();
        case MONITORENTER:      unimplemented();
        case MONITOREXIT:       unimplemented();
        case MULTIANEWARRAY:    unimplemented();
        case NEW:               unimplemented();
        case NEWARRAY:          unimplemented();
        case NOP:               unimplemented();
        case POP:               unimplemented();
        case POP2:              unimplemented();
        case PUTFIELD:          unimplemented();
        case PUTSTATIC:         unimplemented();
        case RET:               unimplemented();
        case RETURN:            unimplemented();
        case SALOAD:            unimplemented();
        case SASTORE:           unimplemented();
        case SIPUSH:            unimplemented();
        case SWAP:              unimplemented();
        case TABLESWITCH:       unimplemented();
        case WIDE:              unimplemented();
        case:                   return false;
    }

    return true;
}