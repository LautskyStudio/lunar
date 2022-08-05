@tool
class_name LansinyDatabaseItemEntry
extends LansinyDatabaseEntry


@export var attr_dict: Dictionary = {}


func _update_attr_dict(type_entry):
	if type_entry:
		var attr_keys = attr_dict.keys()

		# 建立在 TypeEntry 中存在而在 ItemEntry 中缺失的 key
		var valid_keys = []
		for key in type_entry.attr_list:
			valid_keys.append(key)
			if not key in attr_keys:
				attr_dict[key] = key.duplicate()

		# 删除在 TypeEntry 不存在的 key 而在 ItemEntry 中冗余的 key
		for key in attr_dict.keys():
			if not key in valid_keys:
				attr_dict.erase(key)
