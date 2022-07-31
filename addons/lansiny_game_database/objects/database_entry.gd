@tool
class_name DatabaseEntry
extends Resource

signal removed

@export var entry_id: int = randi()
@export var name: String = ""
@export_multiline var description: String = ""
