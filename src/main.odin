package ff4j

import "core:fmt"
import "core:os"

main :: proc() {
    if len(os.args) != 2 {
        fmt.eprintln("Usage: ff4j <file>");
        os.exit(1);
        unreachable();
    }

    vm := make_vm();
    defer delete_vm(vm);

    run_main_class(vm, os.args[1]);
}