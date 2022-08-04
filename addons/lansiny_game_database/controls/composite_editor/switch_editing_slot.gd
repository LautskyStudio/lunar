@tool
extends HBoxContainer


signal value_changed(value)


@export var label_text = "标签文本"
@export var value = false


@onready var label = %"Label" as Label
@onready var check_button = %"CheckButton" as CheckButton


func _ready():
	label.text = label_text
	check_button.button_pressed = value


func set_label_text(text: String) -> void:
	label_text = text
	if self.is_inside_tree():
		label.set_text(text)


func set_value(value):
	self.value = value
	if self.is_inside_tree():
		check_button.button_pressed = value


func _on_check_button_pressed():
	value = check_button.button_pressed
	emit_signal("value_changed", value)
