package fjvm

import "core:fmt"
import "core:os"

main :: proc() {
	data, ok := os.read_entire_file("test.class");
	if !ok do panic("Failed to read class file!");

	c, e := parse_class_file(data);
	if e != .NO_ERROR do fmt.println(e);
	else do fmt.println(c);
}