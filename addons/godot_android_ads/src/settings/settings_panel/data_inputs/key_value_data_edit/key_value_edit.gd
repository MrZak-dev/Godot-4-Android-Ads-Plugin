@tool
extends HBoxContainer
class_name KeyValueEdit

signal data_submitted(data:Dictionary, edit:KeyValueEdit)

@export var _key_name : String
@export var _value_name : String

var key_name: String :
	set(value):
		key_name = value
		key_data_edit.header = value

var value_name: String :
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
	return key_data_edit.get_text()


func get_value() -> String:
	return value_data_edit.get_text()


func set_key(key:String) -> void:
	key_data_edit.set_text(key)


func set_value(value:String) -> void:
	value_data_edit.set_text(value)


func get_data() -> Dictionary:
	return {get_key() : get_value()}


func set_data(key_value:Dictionary) -> void:
	set_key(key_value.keys()[0])
	set_value(key_value.values()[0])


func is_filled() -> bool:
	return not get_key().is_empty() and not get_value().is_empty()


func set_valid() -> void:
	key_data_edit.set_valid()


func set_invalid() -> void:
	key_data_edit.set_invalid()


func _set_signals() -> void:
	key_data_edit.text_validated.connect(
		func():
			if is_filled():
				self.data_submitted.emit(get_data(), self)
	)
	value_data_edit.text_validated.connect(
		func():
			if is_filled():
				self.data_submitted.emit(get_data(), self)
	)


# TODO : set_occupied_values
