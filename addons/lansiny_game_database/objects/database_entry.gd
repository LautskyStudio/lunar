class_name LansinyDatabaseEntry
extends Resource

signal removed

enum NamingType { MANUAL, QUOTE }
enum ValueType { NUMBER, STRING, SWITCH, QUOTE, SELECT }


@export var entry_id: int
@export var name: String = ""
@export var name_quoted_from := 0
@export var naming_type: NamingType = NamingType.MANUAL
@export_multiline var description: String = ""
