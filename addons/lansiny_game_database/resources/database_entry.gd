class_name LansinyDatabaseEntry
extends Resource


signal entry_removed(entry: LansinyDatabaseEntry)
signal entry_changed(entry: LansinyDatabaseEntry)


enum ValueType { NUMBER, STRING, SWITCH, SELECT }


@export var entry_id: int
@export var name: String = "":
	set = set_name
@export_multiline var description: String = "":
	set = set_description


func set_name(p_name):
	name = p_name
	emit_signal("entry_changed", self)


func set_description(p_description):
	description = p_description
	emit_signal("entry_changed", self)


func remove() -> void:
	emit_signal("entry_removed", self)
