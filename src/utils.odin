package ff4j

import "core:os"
import "core:fmt"

fail :: proc(msg: string, args: ..any) {
	fmt.eprintln(fmt.aprintf(msg, ..args));
	os.exit(1);
	unreachable();
}