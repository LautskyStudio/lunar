extends VBoxContainer


signal value_type_changed(value_type)
signal value_changed(value: Variant)


@export var value_type_editable = true
@export var value_type: LansinyDatabaseEntry.ValueType = LansinyDatabaseEntry.ValueType.NUMBER:
	set = set_value_type


@onready var value_type_slot = %ValueTypeEditingSlot
@onready var number_slot = %NumberEditingSlot
@onready var string_slot = %StringEditingSlot
@onready var switch_slot = %SwitchEditingSlot


var bound_attr_entry = null
var label_text: String = "值":
	set = set_label_text
var value_number = 0
var value_string = ""
var value_switch = false


func _set_label_text(text):
	if self.is_inside_tree():
		number_slot.set_label_text(text)
		string_slot.set_label_text(text)
		switch_slot.set_label_text(text)


func _setup_slots():
	if self.is_inside_tree():
		if value_type_editable:
			value_type_slot.visible = true
			set_label_text("值")
		else:
			value_type_slot.visible = false
			set_label_text("%s" % bound_attr_entry.name if bound_attr_entry else "值")

		value_type_slot.set_value(value_type)

		number_slot.set_value(value_number)
		number_slot.visible = value_type == LansinyDatabaseEntry.ValueType.NUMBER

		string_slot.set_value(value_string)
		string_slot.visible = value_type == LansinyDatabaseEntry.ValueType.STRING

		switch_slot.set_value(value_switch)
		switch_slot.visible = value_type == LansinyDatabaseEntry.ValueType.SWITCH


func set_label_text(text):
	label_text = text
	_set_label_text(text)


func set_value_type(p_value_type):
	value_type = p_value_type
	_setup_slots()


func bind_attr_entry(attr_entry):
	bound_attr_entry = attr_entry
	value_type = attr_entry.value_type
	value_number = attr_entry.value_number
	value_string = attr_entry.value_string
	value_switch = attr_entry.value_switch
	_setup_slots()


func _ready():
	_setup_slots()


func get_value():
	match value_type:
		LansinyDatabaseEntry.ValueType.NUMBER:
			return value_number
		LansinyDatabaseEntry.ValueType.STRING:
			return value_string
		LansinyDatabaseEntry.ValueType.SWITCH:
			return value_switch
		_:
			return null


func _on_value_type_editing_slot_value_changed(neo_type):
	value_type = neo_type
	if bound_attr_entry:
		bound_attr_entry.value_type = neo_type
	_setup_slots()
	emit_signal("value_type_changed", value_type)


func _on_number_editing_slot_value_changed(value):
	value_number = value
	if bound_attr_entry:
		bound_attr_entry.value_number = value
	emit_signal("value_changed", value)


func _on_string_editing_slot_value_changed(value):
	value_string = value
	if bound_attr_entry:
		bound_attr_entry.value_string = value
	emit_signal("value_changed", value)


func _on_switch_editing_slot_value_changed(value):
	value_switch = value
	if bound_attr_entry:
		bound_attr_entry.value_switch = value
	emit_signal("value_changed", value)
