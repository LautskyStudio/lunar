@tool
extends HBoxContainer


signal value_changed(value)


@export var label_text = "标签文本"
@export var value: LansinyDatabaseEntry.ValueType = LansinyDatabaseEntry.ValueType.NUMBER


@onready var label = %"Label" as Label
@onready var menu_button = %"MenuButton" as MenuButton
@onready var popup = menu_button.get_popup()


func _ready():
	label.text = label_text
	popup.set_current_index(value)
	menu_button.set_text(popup.get_item_text(popup.get_current_index()))
	popup.connect("id_pressed", self._on_popup_id_pressed)


func set_label_text(text: String) -> void:
	label_text = text
	if self.is_inside_tree():
		label.set_text(text)


func set_value(value):
	self.value = value
	if self.is_inside_tree():
		menu_button.get_popup().set_current_index(value)


func _on_popup_id_pressed(id: int):
	menu_button.set_text(popup.get_item_text(id))
	self.value = id
	emit_signal("value_changed", value)
