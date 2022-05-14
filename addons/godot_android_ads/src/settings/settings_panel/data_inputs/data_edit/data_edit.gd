@tool
extends VBoxContainer
class_name DataEdit

signal text_validated

@export var _header : String

@onready var _header_lbl : Label = get_node("%Header")
@onready var _edit : LineEdit = get_node("%Edit")

var header:
	set(value):
		_header = value
		_header_lbl.set_text(value)
		if not value.is_empty():
			_header_lbl.set_visible(true)


func _ready() -> void:
	header = _header


func get_edit_text() -> String:
	return _edit.get_text()


func _set_edit_text(text:String) -> void:
	_edit.set_text(text)
	_edit.emit_signal("text_validated")


func _clean_spaces(text:String) -> String:
	return text.strip_edges()


func _on_edit_focus_exited() -> void:
	_set_edit_text(_clean_spaces(get_edit_text()))


func _on_edit_text_submitted(new_text: String) -> void:
	_set_edit_text(_clean_spaces(get_edit_text()))
