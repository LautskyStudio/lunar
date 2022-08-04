class_name LansinyDatabaseEntry
extends Resource


signal entry_removed(entry: LansinyDatabaseEntry)
signal entry_changed(entry: LansinyDatabaseEntry)


enum ValueType { NUMBER, STRING, SWITCH, SELECT }


@export var entry_id: int
@export var name: String = ""
@export_multiline var description: String = ""


func remove() -> void:
	emit_signal("entry_removed", self)
