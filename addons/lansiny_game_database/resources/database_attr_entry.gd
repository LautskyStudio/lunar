@tool
class_name LansinyDatabaseAttrEntry
extends LansinyDatabaseEntry


@export var attr_meta: Resource = LansinyDatabaseAttrMeta.new()
@export var value: Resource = LansinyDatabaseValue.new()


var value_type: LansinyDatabaseEntry.ValueType:
	set = set_value_type, get = get_value_type
var value_number: int:
	set = set_value_number, get = get_value_number
var value_string: String:
	set = set_value_string, get = get_value_string
var value_switch: bool:
	set = set_value_switch, get = get_value_switch


func set_value_type(value_type):
	attr_meta.value_type = value_type


func get_value_type():
	return attr_meta.value_type


func set_value_number(number):
	value.number = number


func get_value_number():
	return value.number


func set_value_string(string):
	value.string = string


func get_value_string():
	return value.string


func set_value_switch(switch):
	value.switch = switch


func get_value_switch():
	return value.switch
