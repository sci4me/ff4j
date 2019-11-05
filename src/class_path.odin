package ff4j

import "core:os"
import "core:strings"
import "core:fmt"

load_class_file :: proc(name: string) -> (Class_File, Parse_Error) {
    assert(!strings.contains(name, "/"));

    prefix := "";
    if len(name) >= 4 && name[0:4] == "java" do prefix = "jdk-bin/"; // TODO: HACK

    rname, _ := strings.replace_all(name, ".", "/", context.temp_allocator);
    path := strings.concatenate({prefix, rname, ".class"}, context.temp_allocator);

    data, ok := os.read_entire_file(path);
    if ok do return parse_class_file(data);
    else do return {}, .OTHER;
}