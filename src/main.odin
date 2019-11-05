package ff4j

import "core:fmt"
import "core:os"

main :: proc() {
    if len(os.args) != 2 do fail("Usage: ff4j <file>");

    vm := make_vm();
    defer delete_vm(vm);

    run_main_class(vm, os.args[1]);
}