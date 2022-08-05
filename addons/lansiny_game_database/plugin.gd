@tool
extends EditorPlugin


const EditorPanel = preload("res://addons/lansiny_game_database/editor_panel.tscn")
var editor_panel_instance


func _enter_tree():
	editor_panel_instance = EditorPanel.instantiate()
	get_editor_interface().get_editor_main_control().add_child(editor_panel_instance)
	_make_visible(false)


func _exit_tree():
	if editor_panel_instance:
		editor_panel_instance.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if editor_panel_instance:
		editor_panel_instance.visible = visible


func _get_plugin_name():
	return "数据库"


func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon("Node", "EditorIcons")
