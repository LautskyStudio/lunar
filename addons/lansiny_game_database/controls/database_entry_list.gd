@tool
class_name LansinyDatabaseEntryList
extends VBoxContainer


@export var label_text: String = "数据库条目"
@export_file("*.gd") var entry_class = "res://addons/lansiny_game_database/objects/database_entry.gd":
	set = set_entry_class


@onready var list = %"DatabaseEntryList" as ItemList
@onready var entry_list_label = %"DatabaseEntryListLabel" as Label
@onready var add_entry_button = %"AddEntryButton" as Button
@onready var remove_entry_button = %"RemoveEntryButton" as Button
@onready var move_up_entry_button = %"MoveUpEntryButton" as Button
@onready var move_down_entry_button = %"MoveDownEntryButton" as Button


var array: Array[Resource] = [] # Resource is LansinyDatabaseEntry
var entry_class_script: GDScript = load(entry_class)


func get_selected_list_item_index() -> int:
	var selected_items = list.get_selected_items()
	if selected_items.is_empty():
		return -1
	return selected_items[0]


func set_entry_class(path):
	self.entry_class_script = load(path)


func set_array(array):
	self.array = array
	list.clear()
	for entry in self.array:
		list.add_item(entry.name)


func set_entry_type(entry_type: String):
	self.entry_type = entry_type


func _ready():
	entry_list_label.text = label_text


func swap_array_item(index1: int, index2: int) -> void:
	var temp = array[index1]
	array[index1] = array[index2]
	array[index2] = temp


func _on_add_entry_button_pressed():
	var entry = entry_class_script.new() as LansinyDatabaseEntry
	entry.name = label_text + str(list.item_count + 1)
	array.push_back(entry)
	list.add_item(entry.name)


func _on_remove_entry_button_pressed():
	pass # Replace with function body.


func can_move_list_item_up(index: int) -> bool:
	return index > 0


func _on_move_up_entry_button_pressed() -> void:
	var index = get_selected_list_item_index()
	if can_move_list_item_up(index):
		swap_array_item(index, index - 1)
		list.move_item(index, index - 1)
		update_button_disabled_state(index - 1)


func can_move_list_item_down(index) -> bool:
	return index != -1 and index < list.item_count - 1


func _on_move_down_entry_button_pressed() -> void:
	var index = get_selected_list_item_index()
	if can_move_list_item_down(index):
		list.move_item(index, index + 1)
		swap_array_item(index, index + 1)
		update_button_disabled_state(index + 1)


func update_button_disabled_state(index: int) -> void:
	remove_entry_button.disabled = false
	move_up_entry_button.disabled = !can_move_list_item_up(index)
	move_down_entry_button.disabled = !can_move_list_item_down(index)


func _on_database_entry_list_item_selected(index: int) -> void:
	update_button_disabled_state(index)
