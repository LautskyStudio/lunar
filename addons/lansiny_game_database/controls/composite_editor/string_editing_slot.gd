@tool
extends HBoxContainer


signal value_changed(value)


@export var label_text = "标签文本":
	set = set_label_text
@export var value = ""


@onready var label = %"Label" as Label
@onready var text_edit = %"TextEdit" as TextEdit


func _ready():
	label.text = label_text
	text_edit.text = value


func set_label_text(text: String) -> void:
	label_text = text
	if self.is_inside_tree():
		label.set_text(text)


func set_value(p_value):
	value = p_value
	if self.is_inside_tree():
		text_edit.text = value


func _on_text_edit_text_changed():
	self.value = text_edit.text
	emit_signal("value_changed", text_edit.text)
