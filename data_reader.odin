package fjvm

DataReader :: struct {
	data: []u8,
	index: int
}

@private
more :: inline proc(using r: ^DataReader, n: int = 1) -> bool {
	return index + n - 1 < len(data);
}

read_u8 :: inline proc(using r: ^DataReader) -> (u8, bool) {
	if !more(r) do return 0, false;
	v := data[index];
	index += 1;
	return v, true;
}

read_u16 :: inline proc(using r: ^DataReader) -> (u16, bool) {
	if !more(r, 2) do return 0, false;
	v : u16;
	v |= u16(data[index + 0]) << 8;
	v |= u16(data[index + 1]);
	index += 2;
	return v, true;
}

read_u32 :: inline proc(using r: ^DataReader) -> (u32, bool) {
	if !more(r, 4) do return 0, false;
	v : u32;
	v |= u32(data[index + 0]) << 24;
	v |= u32(data[index + 1]) << 16;
	v |= u32(data[index + 2]) << 8;
	v |= u32(data[index + 3]);
	index += 4;
	return v, true;
}

read_n_static :: inline proc(using r: ^DataReader, $N: int) -> ([N]u8, bool) {
	if !more(r, N) do return {}, false;
	r : [N]u8;
	for i in 0..<N do r[i] = data[index + i]; // TODO: @Optimize
	index += N;
	return r, true;
}

read_n_dynamic :: inline proc(using r: ^DataReader, n: int) -> ([]u8, bool) {
	if !more(r, n) do return {}, false;
	r := make([]u8, n);
	for i in 0..<n do r[i] = data[index + i]; // TODO: @Optimize
	index += n;
	return r, true;
}