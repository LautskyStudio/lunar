extends LansinyDatabaseEntryList


func _on_lansiny_game_database_editor_database_loaded(db):
	self.set_array(db.type_list)
