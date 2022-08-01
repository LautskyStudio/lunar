class_name LansinyDatabaseFormatSaver
extends ResourceFormatSaver


func _get_recognized_extensions(resource: Resource) -> PackedStringArray:
	if resource is LansinyDatabase:
		return PackedStringArray(["lansinydb"])
	return PackedStringArray()


func _recognize(resource: Resource) -> bool:
	if resource is LansinyDatabase:
		return true
	return false


func _save(path: String, resource: Resource, flags: int) -> int:
	var db = resource as LansinyDatabase
	var file = File.new()

	file.open(path, file.WRITE)
	var err = file.get_error()
	if err != OK:
		return err

	file.store_pascal_string(var2str(db.type_list))

	file.close()
	return file.get_error()
