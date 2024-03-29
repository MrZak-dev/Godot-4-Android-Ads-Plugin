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


func get_text() -> String:
	return _edit.get_text()


func set_text(text:String) -> void:
	_edit.set_text(text)


func set_valid() -> void:
	modulate = Color.WHITE


func set_invalid() -> void:
	modulate = Color.RED


func _set_text(text:String) -> void:
	set_text(text)
	text_validated.emit()


func _clean_spaces(text:String) -> String:
	return text.strip_edges()


func _on_edit_focus_exited() -> void:
	set_valid()
	_set_text(_clean_spaces(get_text()))


func _on_edit_text_submitted(new_text: String) -> void:
	set_valid()
	_set_text(_clean_spaces(get_text()))
