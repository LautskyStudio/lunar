@tool
class_name LansinyDatabaseEntry
extends Resource


signal entry_removed(entry: LansinyDatabaseEntry)
signal entry_changed(entry: LansinyDatabaseEntry)


enum ValueType { NUMBER, STRING, SWITCH }


@export var meta: Resource = LansinyDatabaseEntryMeta.new()
@export var name: String:
	set = set_name, get = get_name
@export_multiline var description: String:
	set = set_description, get = get_description


func set_name(name):
	meta.name = name
	emit_signal("entry_changed", self)


func get_name():
	return meta.name


func set_description(description):
	meta.description = description
	emit_signal("entry_changed", self)


func get_description():
	return meta.description


func remove() -> void:
	emit_signal("entry_removed", self)
