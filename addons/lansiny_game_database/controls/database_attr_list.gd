@tool
extends LansinyDatabaseEntryList


@export var parent_type_entry: Resource = null:
	set = set_parent_type_entry


func _init():
	self.set_entry_script_path("res://addons/lansiny_game_database/resources/database_attr_entry.gd")


func _ready():
	list_label.text = "属性"
	if parent_type_entry == null:
		disactivate()


func set_parent_type_entry(type_entry):
	parent_type_entry = type_entry

	if parent_type_entry:
		set_array(parent_type_entry.attr_list)
	else:
		set_array([])

	if self.is_inside_tree():
		if parent_type_entry:
			activate()
		else:
			disactivate()


func _on_type_list_entry_selected(entry):
	set_parent_type_entry(entry)


func _on_type_list_entry_deselected():
	set_parent_type_entry(null)


func _on_item_list_entry_selected(entry):
	clear_selection()
