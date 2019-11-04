package fjvm

// TODO: dry out the parsing code

// TODO: remove fmt import
import "core:fmt"

MAGIC 						:: 0xCAFEBABE;

ACC_PUBLIC					:: 0x0001;
ACC_PRIVATE					:: 0x0002;
ACC_PROTECTED				:: 0x0004;
ACC_STATIC					:: 0x0008;
ACC_FINAL					:: 0x0010;
ACC_SUPER					:: 0x0020;
ACC_SYNCHRONIZED			:: 0x0020;
ACC_BRIDGE					:: 0x0040;
ACC_VARARGS					:: 0x0080;
ACC_NATIVE					:: 0x0100;
ACC_INTERFACE				:: 0x0200;
ACC_ABSTRACT				:: 0x0400;
ACC_STRICT					:: 0x0800;
ACC_SYNTHETIC				:: 0x1000;
ACC_ANNOTATION				:: 0x2000;
ACC_ENUM					:: 0x4000;

CONSTANT_Class 				:: 7;
CONSTANT_Fieldref 			:: 9;
CONSTANT_MethodRef  		:: 10;
CONSTANT_InterfaceMethodref :: 11;
CONSTANT_String				:: 8;
CONSTANT_Integer			:: 3;
CONSTANT_Float				:: 4;
CONSTANT_Long				:: 5;
CONSTANT_Double				:: 6;
CONSTANT_NameAndType		:: 12;
CONSTANT_Utf8				:: 1;
CONSTANT_MethodHandle		:: 15;
CONSTANT_MethodType			:: 16;
CONSTANT_InvokeDynamic		:: 18;

Constant_Class_Info :: struct {
	name_index: u16
}

Constant_Fieldref_Info :: struct {
	class_index: u16,
	name_and_type_index: u16
}

Constant_Methodref_Info :: struct {
	class_index: u16,
	name_and_type_index: u16
}

Constant_InterfaceMethodref_Info :: struct {
	class_index: u16,
	name_and_type_index: u16	
}

Constant_String_Info :: struct {
	string_index: u16
}

Constant_Integer_Info :: struct {
	bytes: [4]u8
}

Constant_Float_Info :: struct {
	bytes: [4]u8
}

Constant_Long_Info :: struct {
	high_bytes: [4]u8,
	low_bytes: [4]u8
}

Constant_Double_Info :: struct {
	high_bytes: [4]u8,
	low_bytes: [4]u8
}

Constant_NameAndType_Info :: struct {
	name_index: u16,
	descriptor_index: u16
}

Constant_Utf8_Info :: struct {
	bytes: []u8
}

Constant_MethodHandle_Info :: struct {
	reference_kind: u8,
	reference_index: u16
}

Constant_MethodType_Info :: struct {
	descriptor_index: u16
}

Constant_InvokeDynamic_Info :: struct {
	bootstrap_method_attr_index: u16,
	name_and_type_index: u16
}

ConstantPool_Info :: union {
	Constant_Class_Info,
	Constant_Fieldref_Info,
	Constant_Methodref_Info,
	Constant_InterfaceMethodref_Info,
	Constant_String_Info,
	Constant_Integer_Info,
	Constant_Float_Info,
	Constant_Long_Info,
	Constant_Double_Info,
	Constant_NameAndType_Info,
	Constant_Utf8_Info,
	Constant_MethodHandle_Info,
	Constant_MethodType_Info,
	Constant_InvokeDynamic_Info
}

Field_Info :: struct {
	access: u16,
	name_index: u16,
	descriptor_index: u16,
	attributes: []Attribute_Info
}

Method_Info :: struct {
	access: u16,
	name_index: u16,
	descriptor_index: u16,
	attributes: []Attribute_Info	
}

ConstantValue_Attribute_Info :: struct {
	index: u16
}

Exception_Table_Entry :: struct {
	start_pc: u16,
	end_pc: u16,
	handler_pc: u16,
	catch_type: u16
}

Code_Attribute_Info :: struct {
	max_stack: u16,
	max_locals: u16,
	code: []u8,
	exception_table: []Exception_Table_Entry,
	attributes: []Attribute_Info
}

StackMapTable_Attribute_Info :: struct {
	// TODO	
}

Exceptions_Attribute_Info :: struct {
	exception_index_table: []u16
}

InnerClass :: struct {
	inner_info_index: u16,
	outer_info_index: u16,
	inner_name_index: u16,
	inner_access: u16
}

InnerClasses_Attribute_Info :: struct {
	classes: []InnerClass
}

EnclosingMethod_Attribute_Info :: struct {
	class_index: u16,
	method_index: u16
}

Synthetic_Attribute_Info :: struct {}

Signature_Attribute_Info :: struct {
	signature_index: u16
}

SourceFile_Attribute_Info :: struct {
	sourcefile_index: u16
}

SourceDebugExtension_Attribute_Info :: struct {
	debug_extension: []u8
}

LineNumberTable_Entry :: struct {
	start_pc: u16,
	line_number: u16
}

LineNumberTable_Attribute_Info :: struct {
	entries: []LineNumberTable_Entry
}

LocalVariableTable_Entry :: struct {
	start_pc: u16,
	length: u16,
	name_index: u16,
	descriptor_index: u16,
	index: u16
}

LocalVariableTable_Attribute_Info :: struct {
	entries: []LocalVariableTable_Entry
}

LocalVariableTypeTable_Entry :: struct {
	start_pc: u16,
	length: u16,
	name_index: u16,
	signature_index: u16,
	index: u16
}

LocalVariableTypeTable_Attribute_Info :: struct {
	entries: []LocalVariableTypeTable_Entry
}

Deprecated_Attribute_Info :: struct {}

Const_Value_Index :: distinct u16;

Enum_Const_Value :: struct {
	type_name_index: u16,
	const_name_index: u16
}

Class_Info_Index :: distinct u16;

ElementValue :: union {
	Const_Value_Index,
	Enum_Const_Value,
	Class_Info_Index,
	Annotation,
	[]ElementValue,
}

ElementValuePair :: struct {
	element_name_index: u16,
	value: ElementValue
}

Annotation :: struct {
	type_index: u16,
	element_value_pairs: []ElementValuePair
}

RuntimeVisibleAnnotations_Attribute_Info :: struct {
	annotations: []Annotation
}

RuntimeInvisibleAnnotations_Attribute_Info :: struct {
	annotations: []Annotation
}

RuntimeVisibleParameterAnnotations_Attribute_Info :: struct {
	annotations: [][]Annotation
}

RuntimeInvisibleParameterAnnotations_Attribute_Info :: struct {
	annotations: [][]Annotation	
}

AnnotationDefault_Attribute_Info :: struct {
	default_value: ElementValue
}

BootstrapMethod :: struct {
	bootstrap_method_ref: u16,
	arguments: []u16
}

BootstrapMethods_Attribute_Info :: struct {
	bootstrap_methods: []BootstrapMethod
}

Unknown_Attribute_Info :: struct {
	bytes: []u8
}

Attribute_Info :: union {
	ConstantValue_Attribute_Info,
	Code_Attribute_Info,
	StackMapTable_Attribute_Info,
	Exceptions_Attribute_Info,
	InnerClasses_Attribute_Info,
	EnclosingMethod_Attribute_Info,
	Synthetic_Attribute_Info,
	Signature_Attribute_Info,
	SourceFile_Attribute_Info,
	SourceDebugExtension_Attribute_Info,
	LineNumberTable_Attribute_Info,
	LocalVariableTable_Attribute_Info,
	LocalVariableTypeTable_Attribute_Info,
	Deprecated_Attribute_Info,
	RuntimeVisibleAnnotations_Attribute_Info,
	RuntimeInvisibleAnnotations_Attribute_Info,
	RuntimeVisibleParameterAnnotations_Attribute_Info,
	RuntimeInvisibleParameterAnnotations_Attribute_Info,
	AnnotationDefault_Attribute_Info,
	BootstrapMethods_Attribute_Info,
	Unknown_Attribute_Info
}

Class_File :: struct {
	minor: u16,
	major: u16,
	constant_pool: []ConstantPool_Info,
	access: u16,
	this_class: u16,
	super_class: u16,
	interfaces: []u16,
	fields: []Field_Info,
	methods: []Method_Info,
	attributes: []Attribute_Info
}

@private
parse_constant_class_info :: proc(r: ^DataReader) -> (Constant_Class_Info, Parse_Error) {
	if name_index, ok := read_u16(r); ok do return Constant_Class_Info{name_index}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_fieldref_info :: proc(r: ^DataReader) -> (Constant_Fieldref_Info, Parse_Error) {
	class_index, name_and_type_index: u16;

	if _class_index, ok := read_u16(r); ok do class_index = _class_index;
	else do return {}, .EOF;

	if _name_and_type_index, ok := read_u16(r); ok do name_and_type_index = _name_and_type_index;
	else do return {}, .EOF;

	return Constant_Fieldref_Info{class_index, name_and_type_index}, .NO_ERROR;
}

@private
parse_constant_methodref_info :: proc(r: ^DataReader) -> (Constant_Methodref_Info, Parse_Error) {
	class_index, name_and_type_index: u16;

	if _class_index, ok := read_u16(r); ok do class_index = _class_index;
	else do return {}, .EOF;

	if _name_and_type_index, ok := read_u16(r); ok do name_and_type_index = _name_and_type_index;
	else do return {}, .EOF;

	return Constant_Methodref_Info{class_index, name_and_type_index}, .NO_ERROR;
}

@private
parse_constant_interface_methodref_info :: proc(r: ^DataReader) -> (Constant_InterfaceMethodref_Info, Parse_Error) {
	class_index, name_and_type_index: u16;

	if _class_index, ok := read_u16(r); ok do class_index = _class_index;
	else do return {}, .EOF;

	if _name_and_type_index, ok := read_u16(r); ok do name_and_type_index = _name_and_type_index;
	else do return {}, .EOF;

	return Constant_InterfaceMethodref_Info{class_index, name_and_type_index}, .NO_ERROR;
}

@private
parse_constant_string_info :: proc(r: ^DataReader) -> (Constant_String_Info, Parse_Error) {
	if string_index, ok := read_u16(r); ok do return Constant_String_Info{string_index}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_integer_info :: proc(r: ^DataReader) -> (Constant_Integer_Info, Parse_Error) {
	if bytes, ok := read_n_static(r, 4); ok do return Constant_Integer_Info{bytes}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_float_info :: proc(r: ^DataReader) -> (Constant_Float_Info, Parse_Error) {
	if bytes, ok := read_n_static(r, 4); ok do return Constant_Float_Info{bytes}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_long_info :: proc(using r: ^DataReader) -> (Constant_Long_Info, Parse_Error) {
	high_bytes, low_bytes: [4]u8;

	if _high_bytes, ok := read_n_static(r, 4); ok do high_bytes = _high_bytes;
	else do return {}, .EOF;

	if _low_bytes, ok := read_n_static(r, 4); ok do low_bytes = _low_bytes;
	else do return {}, .EOF;

	return Constant_Long_Info{high_bytes, low_bytes}, .NO_ERROR;
}

@private
parse_constant_double_info :: proc(using r: ^DataReader) -> (Constant_Double_Info, Parse_Error) {
	high_bytes, low_bytes: [4]u8;

	if _high_bytes, ok := read_n_static(r, 4); ok do high_bytes = _high_bytes;
	else do return {}, .EOF;

	if _low_bytes, ok := read_n_static(r, 4); ok do low_bytes = _low_bytes;
	else do return {}, .EOF;

	return Constant_Double_Info{high_bytes, low_bytes}, .NO_ERROR;
}

@private
parse_constant_nameandtype_info :: proc(r: ^DataReader) -> (Constant_NameAndType_Info, Parse_Error) {
	name_index, descriptor_index: u16;

	if _name_index, ok := read_u16(r); ok do name_index = _name_index;
	else do return {}, .EOF;

	if _descriptor_index, ok := read_u16(r); ok do descriptor_index = _descriptor_index;
	else do return {}, .EOF;

	return Constant_NameAndType_Info{name_index, descriptor_index}, .NO_ERROR;
}

@private
parse_constant_utf8_info :: proc(r: ^DataReader) -> (Constant_Utf8_Info, Parse_Error) {
	length: u16;

	if _length, ok := read_u16(r); ok do length = _length;
	else do return {}, .EOF;

	if bytes, ok := read_n_dynamic(r, int(length)); ok do return Constant_Utf8_Info{bytes}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_methodhandle_info :: proc(r: ^DataReader) -> (Constant_MethodHandle_Info, Parse_Error) {
	reference_kind: u8;
	reference_index: u16;

	if _reference_kind, ok := read_u8(r); ok do reference_kind = _reference_kind;
	else do return {}, .EOF;

	if _reference_index, ok := read_u16(r); ok do reference_index = _reference_index;
	else do return {}, .EOF;

	return Constant_MethodHandle_Info{reference_kind, reference_index}, .NO_ERROR;
}

@private
parse_constant_methodtype_info :: proc(r: ^DataReader) -> (Constant_MethodType_Info, Parse_Error) {
	if descriptor_index, ok := read_u16(r); ok do return Constant_MethodType_Info{descriptor_index}, .NO_ERROR;
	else do return {}, .EOF;
}

@private
parse_constant_invokedynamic_info :: proc(r: ^DataReader) -> (Constant_InvokeDynamic_Info, Parse_Error) {
	bootstrap_method_attr_index, name_and_type_index: u16;

	if _bootstrap_method_attr_index, ok := read_u16(r); ok do bootstrap_method_attr_index = _bootstrap_method_attr_index;
	else do return {}, .EOF;

	if _name_and_type_index, ok := read_u16(r); ok do name_and_type_index = _name_and_type_index;
	else do return {}, .EOF;

	return Constant_InvokeDynamic_Info{bootstrap_method_attr_index, name_and_type_index}, .NO_ERROR;
}

@private
parse_constant_pool_info :: proc(r: ^DataReader) -> (ConstantPool_Info, Parse_Error) {
	tag : u8;

	if _tag, ok := read_u8(r); ok do tag = _tag;
	else do return nil, .EOF;

	switch tag {
		case CONSTANT_Class: 				return parse_constant_class_info(r);
		case CONSTANT_Fieldref: 			return parse_constant_fieldref_info(r);
		case CONSTANT_MethodRef:			return parse_constant_methodref_info(r);
		case CONSTANT_InterfaceMethodref:	return parse_constant_interface_methodref_info(r);
		case CONSTANT_String:				return parse_constant_string_info(r);
		case CONSTANT_Integer:				return parse_constant_integer_info(r);
		case CONSTANT_Float:				return parse_constant_float_info(r);
		case CONSTANT_Long:					return parse_constant_long_info(r);
		case CONSTANT_Double:				return parse_constant_double_info(r);
		case CONSTANT_NameAndType:			return parse_constant_nameandtype_info(r);
		case CONSTANT_Utf8:					return parse_constant_utf8_info(r);
		case CONSTANT_MethodHandle:			return parse_constant_methodhandle_info(r);
		case CONSTANT_MethodType:			return parse_constant_methodtype_info(r);
		case CONSTANT_InvokeDynamic:		return parse_constant_invokedynamic_info(r);
	}

	return nil, .BAD_CONSTANT_INFO_TAG;
}

@private
parse_constant_pool :: proc(r: ^DataReader) -> ([]ConstantPool_Info, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]ConstantPool_Info, count);
	i := u16(1);
	for i < count {
		if info, err := parse_constant_pool_info(r); err == .NO_ERROR {
			result[i] = info;
			i += 1;

			// https://docs.oracle.com/javase/specs/jvms/se7/html/jvms-4.html#jvms-4.4.5
			_, is_long := info.(Constant_Long_Info);
			_, is_double := info.(Constant_Double_Info);
			if is_long || is_double do i += 1;
		} else do return nil, err;
	}

	return result, .NO_ERROR;
}

Parse_Error :: enum {
	NO_ERROR,
	EOF,
	BAD_MAGIC,
	BAD_CONSTANT_INFO_TAG,
	BAD_ATTRIBUTE_NAME_INDEX,
	ATTRIBUTE_NAME_IS_NOT_UTF8_CONSTANT,
	OTHER
}

@private
parse_interfaces :: proc(r: ^DataReader) -> ([]u16, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]u16, count);
	for i in 0..<count {
		if x, ok := read_u16(r); ok do result[i] = x;
		else do return nil, .EOF;
	}

	return result, .NO_ERROR;
}

// ConstantValue

@private
parse_code_attribute_info :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> (Code_Attribute_Info, Parse_Error) {
	parse_exception_table :: proc(r: ^DataReader) -> ([]Exception_Table_Entry, Parse_Error) {
		parse_entry :: proc(r: ^DataReader) -> (Exception_Table_Entry, Parse_Error) {
			unimplemented();
			return {}, .OTHER;
		}

		count: u16;

		if _count, ok := read_u16(r); ok do count = _count;
		else do return {}, .EOF;

		result := make([]Exception_Table_Entry, count);
		for i in 0..<count {
			if entry, err := parse_entry(r); err == .NO_ERROR do result[i] = entry;
			else do return {}, err;
		}

		return result, .NO_ERROR;
	}

	max_stack, max_locals: u16;
	code_length: u32;
	code: []u8;
	exception_table: []Exception_Table_Entry;
	attributes: []Attribute_Info;

	if _max_stack, ok := read_u16(r); ok do max_stack = _max_stack;
	else do return {}, .EOF;

	if _max_locals, ok := read_u16(r); ok do max_locals = _max_locals;
	else do return {}, .EOF;

	if _code_length, ok := read_u32(r); ok do code_length = _code_length;
	else do return {}, .EOF;

	if _code, ok := read_n_dynamic(r, int(code_length)); ok do code = _code;
	else do return {}, .EOF;

	if _exception_table, err := parse_exception_table(r); err == .NO_ERROR do exception_table = _exception_table;
	else do return {}, err;

	if _attributes, err := parse_attributes(r, constant_pool); err == .NO_ERROR do attributes = _attributes;
	else do return {}, err;

	return Code_Attribute_Info{max_stack, max_locals, code, exception_table, attributes}, .NO_ERROR;
}

// StackMapTable
// Exceptions
// InnerClasses
// EnclosingMethod
// Synthetic
// Signature

@private
parse_source_file_attribute_info :: proc(r: ^DataReader) -> (SourceFile_Attribute_Info, Parse_Error) {
	if sourcefile_index, ok := read_u16(r); ok do return SourceFile_Attribute_Info{sourcefile_index}, .NO_ERROR;
	else do return {}, .EOF;
}

// SourceDebugExtension

@private
parse_line_number_table_entry :: proc(r: ^DataReader) -> (LineNumberTable_Entry, Parse_Error) {
	start_pc, line_number: u16;

	if _start_pc, ok := read_u16(r); ok do start_pc = _start_pc;
	else do return {}, .EOF;

	if _line_number, ok := read_u16(r); ok do line_number = _line_number;
	else do return {}, .EOF;

	return LineNumberTable_Entry{start_pc, line_number}, .NO_ERROR;
}

@private
parse_line_number_table_attribute_info :: proc(r: ^DataReader) -> (LineNumberTable_Attribute_Info, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return {}, .EOF;

	entries := make([]LineNumberTable_Entry, count);
	for i in 0..<count {
		if entry, err := parse_line_number_table_entry(r); err == .NO_ERROR do entries[i] = entry;
		else do return {}, err;
	}

	return LineNumberTable_Attribute_Info{entries}, .NO_ERROR;
}

// LocalVariableTable
// Deprecated
// RuntimeVisibleAnnotations
// RuntimeInvisibleAnnotations
// RuntimeVisibleParameterAnnotations
// RuntimeInvisibleParameterAnnotations
// AnnotationDefault
// BootstrapMethods

@private
parse_attribute :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> (Attribute_Info, Parse_Error) {
	attribute_name_index: u16;
	attribute_name: string;
	attribute_length: u32;

	if _attribute_name_index, ok := read_u16(r); ok do attribute_name_index = _attribute_name_index;
	else do return {}, .EOF;

	if attribute_name_index == 0 || int(attribute_name_index) >= len(constant_pool) do return {}, .BAD_ATTRIBUTE_NAME_INDEX;	

	name_entry := constant_pool[attribute_name_index];
	if name_utf8, ok := name_entry.(Constant_Utf8_Info); ok do attribute_name = string(name_utf8.bytes);
	else do return {}, .ATTRIBUTE_NAME_IS_NOT_UTF8_CONSTANT;

	if _attribute_length, ok := read_u32(r); ok do attribute_length = _attribute_length;
	else do return {}, .EOF;

	switch attribute_name {
		case "ConstantValue":							unimplemented();
		case "Code":									return parse_code_attribute_info(r, constant_pool);
		case "StackMapTable":							unimplemented();
		case "Exceptions":								unimplemented();
		case "InnerClasses":							unimplemented();
		case "EnclosingMethod":							unimplemented();
		case "Synthetic":								unimplemented();
		case "Signature":								unimplemented();
		case "SourceFile":								return parse_source_file_attribute_info(r);
		case "SourceDebugExtension":					unimplemented();
		case "LineNumberTable":							return parse_line_number_table_attribute_info(r);
		case "LocalVariableTable":						unimplemented();
		case "Deprecated":								unimplemented();
		case "RuntimeVisibleAnnotations":				unimplemented();
		case "RuntimeInvisibleAnnotations":				unimplemented();
		case "RuntimeVisibleParameterAnnotations":		unimplemented();
		case "RuntimeInvisibleParameterAnnotations":	unimplemented();
		case "AnnotationDefault":						unimplemented();
		case "BootstrapMethods":						unimplemented();
	}

	if bytes, ok := read_n_dynamic(r, int(attribute_length)); ok do return Unknown_Attribute_Info{bytes}, .NO_ERROR;
	else do return nil, .EOF;
}

@private
parse_attributes :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> ([]Attribute_Info, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]Attribute_Info, count);
	for i in 0..<count {
		if attribute, err := parse_attribute(r, constant_pool); err == .NO_ERROR do result[i] = attribute;
		else do return nil, err;
	}

	return result, .NO_ERROR;
}

@private
parse_field :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> (Field_Info, Parse_Error) {
	access, name_index, descriptor_index: u16;
	attributes: []Attribute_Info;

	if _access, ok := read_u16(r); ok do access = _access;
	else do return {}, .EOF;

	if _name_index, ok := read_u16(r); ok do name_index = _name_index;
	else do return {}, .EOF;

	if _descriptor_index, ok := read_u16(r); ok do descriptor_index = _descriptor_index;
	else do return {}, .EOF;

	if _attributes, err := parse_attributes(r, constant_pool); err == .NO_ERROR do attributes = _attributes;
	else do return {}, err;

	return Field_Info{access, name_index, descriptor_index, attributes}, .NO_ERROR;
}

@private
parse_method :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> (Method_Info, Parse_Error) {
	access, name_index, descriptor_index: u16;
	attributes: []Attribute_Info;

	if _access, ok := read_u16(r); ok do access = _access;
	else do return {}, .EOF;

	if _name_index, ok := read_u16(r); ok do name_index = _name_index;
	else do return {}, .EOF;

	if _descriptor_index, ok := read_u16(r); ok do descriptor_index = _descriptor_index;
	else do return {}, .EOF;

	if _attributes, err := parse_attributes(r, constant_pool); err == .NO_ERROR do attributes = _attributes;
	else do return {}, err;

	return Method_Info{access, name_index, descriptor_index, attributes}, .NO_ERROR;	
}

@private
parse_fields :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> ([]Field_Info, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]Field_Info, count);
	for i in 0..<count {
		if field_info, err := parse_field(r, constant_pool); err == .NO_ERROR do result[i] = field_info;
		else do return nil, err;
	}

	return result, .NO_ERROR;
}

@private
parse_methods :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info) -> ([]Method_Info, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]Method_Info, count);
	for i in 0..<count {
		if method_info, err := parse_method(r, constant_pool); err == .NO_ERROR do result[i] = method_info;
		else do return nil, err;
	}

	return result, .NO_ERROR;
}

/*
@private
parse_many :: proc(r: ^DataReader, constant_pool: []ConstantPool_Info, parse_fn: proc(^DataReader, []ConstantPool_Info) -> ($T, Parse_Error)) -> ([]T, Parse_Error) {
	count: u16;

	if _count, ok := read_u16(r); ok do count = _count;
	else do return nil, .EOF;

	result := make([]T, count);
	for i in 0..<count {
		if x, err := parse_fn(r, constant_pool); err == .NO_ERROR do result[i] = x;
		else do return nil, err;
	}

	return result, .NO_ERROR;
}
*/

parse_class_file :: proc(data: []u8) -> (Class_File, Parse_Error) {
	dr := DataReader{data, 0};
	r := &dr;

	minor, major: u16;
	constant_pool: []ConstantPool_Info;
	access, this_class, super_class: u16;
	interfaces: []u16;
	fields: []Field_Info;
	methods: []Method_Info;
	attributes: []Attribute_Info;

	if magic, ok := read_u32(r); ok {
		if magic != MAGIC do return {}, .BAD_MAGIC;
	} else do return {}, .EOF;

	if _minor, ok := read_u16(r); ok do minor = _minor;
	else do return {}, .EOF;

	if _major, ok := read_u16(r); ok do major = _major;
	else do return {}, .EOF;

	// TODO: check versions?

	if _constant_pool, err := parse_constant_pool(r); err == .NO_ERROR do constant_pool = _constant_pool;
	else do return {}, err;

	if _access, ok := read_u16(r); ok do access = _access;
	else do return {}, .EOF;

	if _this_class, ok := read_u16(r); ok do this_class = _this_class;
	else do return {}, .EOF;

	if _super_class, ok := read_u16(r); ok do super_class = _super_class;
	else do return {}, .EOF;

	if _interfaces, err := parse_interfaces(r); err == .NO_ERROR do interfaces = _interfaces;
	else do return {}, err;

	if _fields, err := parse_fields(r, constant_pool); err == .NO_ERROR do fields = _fields;
	else do return {}, err;

	if _methods, err := parse_methods(r, constant_pool); err == .NO_ERROR do methods = _methods;
	else do return {}, err;

	if _attributes, err := parse_attributes(r, constant_pool); err == .NO_ERROR do attributes = _attributes;
	else do return {}, err;

	return Class_File{
		minor,
		major,
		constant_pool,
		access,
		this_class,
		super_class,
		interfaces,
		fields,
		methods,
		attributes
	}, .NO_ERROR;
}