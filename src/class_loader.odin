package fjvm

import "core:fmt"

Class_Loader :: struct {
	class_by_name: map[string]^Class	
}

make_class_loader :: proc() -> ^Class_Loader {
	cl := new(Class_Loader);
	cl.class_by_name = make(map[string]^Class);
	return cl;
}

delete_class_loader :: proc(using cl: ^Class_Loader) {
	delete(class_by_name);
	free(cl);
}

get_class_by_name :: proc(using cl: ^Class_Loader, name: string) -> ^Class {
	if class, ok := class_by_name[name]; ok do return class;

	class_file, err := load_class_file(name);
	if err != .NO_ERROR {
		// TODO
		return nil;
	}

	class, ok := load_class_from_class_file(cl, class_file);
	if !ok {
		// TODO
		return nil;
	}

	class_by_name[name] = class;
	return class;
}