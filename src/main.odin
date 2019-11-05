package ff4j

import "core:fmt"
import "core:os"

main :: proc() {
	if len(os.args) != 2 {
		fmt.eprintln("Usage: ff4j <file>");
		os.exit(1);
		unreachable();
	}

	cl := make_class_loader();
	defer delete_class_loader(cl);

	c, err := get_class_by_name(cl, os.args[1]);
	if err == .NO_ERROR do fmt.println(c);
	else do fmt.println(c);
}