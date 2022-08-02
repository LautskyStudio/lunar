@tool
extends LansinyDatabaseEntryList


func _init():
	self.set_entry_script_path("res://addons/lansiny_game_database/objects/database_type_entry.gd")


func _ready():
	self.list_label.set_text("类型")


func _on_lansiny_game_database_editor_database_loaded(db):
	self.set_array(db.type_list)
	emit_signal("entry_deselected")
