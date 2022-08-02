@tool
extends VBoxContainer


signal database_loaded(db: LansinyDatabase)


var db: LansinyDatabase
var db_path := "res://main_lansinydb.tres"


func _ready():
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
	load_main_database()
