@tool
class_name LansinyDatabaseEntryCompositeEditor
extends VBoxContainer


const NumberEditingSlot = preload("res://addons/lansiny_game_database/controls/composite_editor/number_editing_slot.tscn")
const StringEditingSlot = preload("res://addons/lansiny_game_database/controls/composite_editor/string_editing_slot.tscn")
const SwitchEditingSlot = preload("res://addons/lansiny_game_database/controls/composite_editor/switch_editing_slot.tscn")
const ValueEditingSlot = preload("res://addons/lansiny_game_database/controls/composite_editor/value_editing_slot.tscn")
const ValueTypeEditingSlot = preload("res://addons/lansiny_game_database/controls/composite_editor/value_type_editing_slot.tscn")


@onready var entry_type_indicator = %"EntryTypeIndicator" as Label
@onready var slot_container = %EditingSlotContainer as VBoxContainer


var type_entry: Resource = null:
	set = set_type_entry
var editing_entry: Resource = null:
	set = set_editing_entry


func set_type_entry(p_type_entry):
	type_entry = p_type_entry


func set_editing_entry(entry):
	if editing_entry:
		editing_entry.disconnect("entry_removed", self._on_editing_entry_removed)

	editing_entry = entry
	if editing_entry:
		editing_entry.connect("entry_removed", self._on_editing_entry_removed)

	if self.is_inside_tree():
		clear_entry_editor()
		setup_entry_editor()


func setup_entry_editor() -> void:
	if editing_entry == null:
		entry_type_indicator.set_text("选中数据库条目以进行编辑…")
	elif editing_entry is LansinyDatabaseTypeEntry:
		setup_type_entry_editor()
	elif editing_entry is LansinyDatabaseAttrEntry:
		setup_attr_entry_editor()
	elif editing_entry is LansinyDatabaseItemEntry:
		setup_value_entry_editor()
	else:
		entry_type_indicator.set_text("未知状态")


func setup_type_entry_editor():
	entry_type_indicator.set_text("类型定义")
	add_slot(StringEditingSlot, "类型名称", "name")
	add_slot(StringEditingSlot, "类型注释", "description")


func setup_attr_entry_editor():
	entry_type_indicator.set_text("属性定义")
	add_slot(StringEditingSlot, "属性名称", "name")
	add_slot(StringEditingSlot, "属性注释", "description")
	add_value_editing_slot(editing_entry)


func setup_value_entry_editor():
	entry_type_indicator.set_text("数据编辑")
	editing_entry._update_attr_dict(type_entry)
	add_slot(StringEditingSlot, "数据名称", "name")
	add_slot(StringEditingSlot, "数据注释", "description")
	for key in editing_entry.attr_dict.keys():
		add_value_editing_slot(editing_entry.attr_dict[key], false)


func clear_entry_editor():
	for node in slot_container.get_children():
		node.queue_free()


func _on_editing_entry_removed(entry):
	set_editing_entry(null)


func add_slot(packed_slot: PackedScene, label_text, entry_prop):
	var slot = packed_slot.instantiate()
	slot.label_text = label_text
	slot.set_value(editing_entry[entry_prop])
	slot.connect("value_changed", func (value): editing_entry[entry_prop] = value)
	slot_container.add_child(slot)


func add_value_editing_slot(attr_entry, value_type_editable = true):
	var slot = ValueEditingSlot.instantiate()
	slot.value_type_editable = value_type_editable
	slot.bind_attr_entry(attr_entry)
	slot_container.add_child(slot)


func _on_type_list_entry_selected(entry):
	set_editing_entry(entry)
	set_type_entry(entry)


func _on_attr_list_entry_selected(entry):
	set_editing_entry(entry)


func _on_item_list_entry_selected(entry):
	set_editing_entry(entry)
	if not type_entry:
		printerr("BUG: 无法编辑无主的 ItemEntry。")
		printerr("\t", var2str(entry))
		print_stack()
		assert(type_entry)


func _on_type_list_entry_deselected():
	set_editing_entry(null)
