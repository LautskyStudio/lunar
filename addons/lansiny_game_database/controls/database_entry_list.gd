@tool
class_name LansinyDatabaseEntryList
extends VBoxContainer


signal entry_deselected
signal entry_selected(entry)


@onready var list = %"DatabaseEntryList" as ItemList
@onready var list_label = %"DatabaseEntryListLabel" as Label
@onready var add_entry_button = %"AddEntryButton" as Button
@onready var remove_entry_button = %"RemoveEntryButton" as Button
@onready var move_up_entry_button = %"MoveUpEntryButton" as Button
@onready var move_down_entry_button = %"MoveDownEntryButton" as Button


var array = [] # Array[LansinyDatabaseEntry]
var entry_script_path = "res://addons/lansiny_game_database/resources/database_entry.gd":
	set = set_entry_script_path
var entry_script: GDScript = load(entry_script_path)


func activate():
	update_tool_button_state(get_selected_list_item_index(), true)


func disactivate():
	update_tool_button_state(-1, false)


func clear_selection():
	list.deselect_all()
	emit_signal("entry_deselected")


func get_selected_list_item_index() -> int:
	var selected_items = list.get_selected_items()
	if selected_items.is_empty():
		return -1
	return selected_items[0]


func set_entry_script_path(path):
	entry_script_path = path
	entry_script = load(path)


func add_entry(entry):
	entry.connect("entry_changed", self._on_entry_changed)
	entry.connect("entry_removed", self._on_entry_removed)

	if self.is_inside_tree():
		list.add_item(entry.name)
		list.set_item_tooltip(list.item_count - 1, entry.description)
		list.set_item_metadata(list.item_count - 1, entry)


func remove_entry(entry):
	entry.disconnect("entry_changed", self._on_entry_changed)
	entry.disconnect("entry_removed", self._on_entry_removed)


func set_array(array):
	for entry in self.array:
		remove_entry(entry)

	if self.is_inside_tree():
		list.clear()
		emit_signal("entry_deselected")

	self.array = array
	for entry in self.array:
		add_entry(entry)


func set_entry_type(entry_type: String):
	self.entry_type = entry_type


func swap_array_item(index1: int, index2: int) -> void:
	var temp = array[index1]
	array[index1] = array[index2]
	array[index2] = temp


func _on_add_entry_button_pressed():
	var entry = entry_script.new() as LansinyDatabaseEntry
	entry.name = list_label.text + str(list.item_count + 1)
	array.push_back(entry)
	add_entry(entry)
	emit_signal("entry_selected", entry)


func can_remove_list_item(index):
	return index >= 0 and index < list.item_count


func _on_remove_entry_button_pressed():
	var index = get_selected_list_item_index()
	if index >= 0:
		var entry = array[index]
		entry.remove()


func _on_entry_changed(changed_entry):
	for idx in range(list.item_count):
		if list.get_item_metadata(idx) == changed_entry:
			list.set_item_text(idx, changed_entry.name)
			list.set_item_tooltip(idx, changed_entry.description)


func _on_entry_removed(removed_entry):
	for idx in range(list.item_count):
		if list.get_item_metadata(idx) == removed_entry:
			array.remove_at(idx)
			list.remove_item(idx)
			emit_signal("entry_deselected")
			break


func can_move_list_item_up(index: int) -> bool:
	return index > 0


func _on_move_up_entry_button_pressed() -> void:
	var index = get_selected_list_item_index()
	if can_move_list_item_up(index):
		swap_array_item(index, index - 1)
		list.move_item(index, index - 1)
		update_tool_button_state(index - 1)


func can_move_list_item_down(index) -> bool:
	return index != -1 and index < list.item_count - 1


func _on_move_down_entry_button_pressed() -> void:
	var index = get_selected_list_item_index()
	if can_move_list_item_down(index):
		list.move_item(index, index + 1)
		swap_array_item(index, index + 1)
		update_tool_button_state(index + 1)


func update_tool_button_state(selected_item_index: int, can_add_list_item = true) -> void:
	add_entry_button.disabled = !can_add_list_item
	remove_entry_button.disabled = !can_remove_list_item(selected_item_index)
	move_up_entry_button.disabled = !can_move_list_item_up(selected_item_index)
	move_down_entry_button.disabled = !can_move_list_item_down(selected_item_index)


func _on_database_entry_list_item_selected(index: int) -> void:
	update_tool_button_state(index)
	emit_signal("entry_selected", self.array[index])


func _on_database_entry_list_empty_clicked(at_position, mouse_button_index):
	clear_selection()
