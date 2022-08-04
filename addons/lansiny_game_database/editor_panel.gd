@tool
extends VBoxContainer


signal database_loaded(db: Resource)


@onready var database_path_indicator = %DatabasePathIndicator
@onready var type_list = %TypeList


var db: LansinyDatabase
var db_path := "res://main_lansinydb.tres"


func _ready():
	database_path_indicator.set_text(db_path)
	load_main_database()


func load_main_database():
	db = load(db_path)
	if db == null or not (db is LansinyDatabase):
		db = LansinyDatabase.new()
	emit_signal("database_loaded", db)


func _on_create_button_pressed():
	db = LansinyDatabase.new()
	emit_signal("database_loaded", db)


func _on_save_button_pressed():
	ResourceSaver.save(db_path, db)


func _on_load_button_pressed():
	type_list.clear_selection()
	load_main_database()
