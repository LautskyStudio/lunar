@tool
extends HBoxContainer


signal value_changed(value)


@export var label_text = "标签文本":
	set = set_label_text
@export var value = 0


@onready var label = %"Label" as Label
@onready var spin_box = %"SpinBox" as SpinBox


func _ready():
	label.text = label_text
	spin_box.value = value


func set_label_text(text: String) -> void:
	label_text = text
	if self.is_inside_tree():
		label.set_text(text)


func set_value(value):
	self.value = value
	if self.is_inside_tree():
		spin_box.value = value


func _on_spin_box_value_changed(value):
	self.value = value
	emit_signal("value_changed", value)
