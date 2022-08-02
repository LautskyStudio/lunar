@tool
class_name NumberedItemList
extends ItemList


@export var numbering_enabled = true
@export_range(0, 4) var minimun_numbering_digits = 2

var item_texts: Array = []


func _swap_item_texts(idx1: int, idx2: int) -> void:
	var temp = item_texts[idx1]
	self.item_texts[idx1] = item_texts[idx2]
	self.item_texts[idx2] = temp


func clear() -> void:
	super.clear()
	self.item_texts.clear()


func _make_item_text_prefix(idx: int) -> String:
	if !self.numbering_enabled:
		return ""

	var numbering_digits = max(str(self.item_count).length(), self.minimun_numbering_digits)
	return ("%0" + ("%dd" % [numbering_digits])) % [idx + 1]


func get_item_text(idx: int) -> String:
	return item_texts[idx]


func _make_full_item_text(idx: int, text: String) -> String:
	return self._make_item_text_prefix(idx) + " " + text


func set_item_text(idx: int, text: String) -> void:
	super.set_item_text(idx, self._make_full_item_text(idx, text))
	self.item_texts[idx] = text


func get_item_text_with_prefix(idx: int) -> String:
	return super.get_item_text(idx)


func add_item(text: String, icon: Texture2D = null, selectable: bool = true):
	super.add_item(_make_full_item_text(self.item_count, text), icon, selectable)
	self.item_texts.append(text)


func move_item(from_idx: int, to_idx: int) -> void:
	super.move_item(from_idx, to_idx)
	self._swap_item_texts(from_idx, to_idx)
	self.set_item_text(from_idx, item_texts[from_idx])
	self.set_item_text(to_idx, item_texts[to_idx])


func remove_item(idx: int) -> void:
	super.remove_item(idx)
	self.item_texts.remove_at(idx)
	for i in range(idx, self.item_count): # 对 idx 位置及之后的项目重新编号
		self.set_item_text(i, item_texts[i])
