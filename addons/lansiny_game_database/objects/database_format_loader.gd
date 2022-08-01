class_name LansinyDatabaseFormatLoader
extends ResourceFormatLoader


func _get_recognized_extensions():
	return PackedStringArray(["lansinydb"])


func _get_resource_type(path: String):
	if path.ends_with("lansinydb"):
		return "LansinyDatabase"
	return ""


func _load(path: String, original_path: String, use_sub_threads: bool, cache_mode: int):
	var db = LansinyDatabase.new()

	var file = File.new()
	file.open(path, File.READ)
	var err = file.get_error()
	if err != OK:
		return err

	var type_list_data = str2var(file.get_pascal_string())
	for item in type_list_data:
		var entry = LansinyDatabaseTypeEntry.new()
		entry.name = item.name
		db.type_list.append(entry)

	file.close()
	return db


func _handles_type(type: StringName):
	if type == StringName("LansinyDatabase"):
		return true
	return false
