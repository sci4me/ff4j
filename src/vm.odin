package ff4j;

import "core:fmt"

VM :: struct {
	class_loader: ^Class_Loader,
	threads: [dynamic]^Java_Thread
}

make_vm :: proc() -> ^VM {
	using vm := new(VM);
	class_loader = make_class_loader();
	return vm;
}

delete_vm :: proc(using vm: ^VM) {
	delete_class_loader(class_loader);
	free(vm);
}

run_main_class :: proc(using vm: ^VM, name: string) {
	class, err := get_class_by_name(class_loader, name);
	if err != .NO_ERROR do fail("Error: Could not find or load main class %s", name);

	instance := make_object(class); // TODO: heap, etc.

	main_method, ok := class.method_by_name_and_descriptor["main([Ljava/lang/String;)V"];
	if !ok do fail("Error: Main method not found in class %s, please define the main method as:\n   public static void main(String[] args)", name);

	thread := make_java_thread(instance, main_method);
	append(&threads, thread);

	run(vm);
}

@private
run :: proc(using vm: ^VM) {
	for len(threads) > 0 {

	}
}