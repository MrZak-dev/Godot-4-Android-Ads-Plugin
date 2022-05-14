@tool
extends HBoxContainer
class_name KeyValueEdit

signal data_submitted

@export var _key_name : String
@export var _value_name : String

var key_name:
	set(value):
		key_name = value
		key_data_edit.header = value

var value_name:
	set(value):
		value_name = value
		value_data_edit.header = value

@onready var key_data_edit : DataEdit = get_node("%KeyEdit")
@onready var value_data_edit : DataEdit = get_node("%ValueEdit")


func _ready() -> void:
	key_name = _key_name
	value_name = _value_name
	_set_signals()


func get_key() -> String:
	return key_data_edit.get_edit_text()


func get_value() -> String:
	return value_data_edit.get_edit_text()


func get_data() -> Dictionary:
	return {get_key() : get_value()}


func _set_signals() -> void:
	key_data_edit.connect(
		"text_validated", Callable(self, "emit_signal"),["data_submitted"])
	
	value_data_edit.connect(
		"text_validated", Callable(self, "emit_signal"),["data_submitted"])
