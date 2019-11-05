package fjvm

import "core:fmt"
import "core:os"

main :: proc() {
	if len(os.args) != 2 {
		fmt.eprintln("Usage: fjvm <file>");
		os.exit(1);
		unreachable();
	}

	cl := make_class_loader();
	defer delete_class_loader(cl);

	c := get_class_by_name(cl, os.args[1]);
	fmt.println(c);
}