@tool
extends VBoxContainer


signal database_loaded(db: LansinyDatabase)


var db: LansinyDatabase
var db_path := "res://main.lansinydb"


func _ready():
	load_main_database()


func load_main_database():
	db = ResourceLoader.load(db_path, "LansinyDatabase")
	if !db or not db is LansinyDatabase:
		db = LansinyDatabase.new()
	emit_signal("database_loaded", db)


func _on_create_button_pressed():
	db = LansinyDatabase.new()
	emit_signal("database_loaded", db)


func _on_save_button_pressed():
	print("type_list", db.type_list)
	ResourceSaver.save(db_path, db)


func _on_load_button_pressed():
	db = ResourceLoader.load(db_path, "LansinyDatabase")
	emit_signal("database_loaded", db)
