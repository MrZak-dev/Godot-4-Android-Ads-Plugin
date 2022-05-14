@tool
extends PanelContainer
class_name KeyValueDataSetInput


const _input_scn : PackedScene = preload(
	"res://addons/godot_android_ads/src/settings/settings_panel/data_inputs/key_value_data_edit/key_value_removable/KeyValueRemovableEdit.tscn")

@export_node_path(VBoxContainer) var _inputs_container_path
@export var _data_set_header : String
@export var _data_set_key_header : String
@export var _data_set_value_header : String

@onready var _inputs_container : VBoxContainer = get_node(
	_inputs_container_path)
@onready var _set_header_lbl : Label = get_node("%Header")

func _ready() -> void:
	_add_key_value_input()
	set_header_text()


func set_header_text() -> void:
	_set_header_lbl.set_text(_data_set_header)


func _add_key_value_input() -> void:
	var _key_value_input : KeyValueRemovableEdit = _input_scn.instantiate()
	_inputs_container.add_child(_key_value_input)
	
	_key_value_input.key_name = _data_set_key_header
	_key_value_input.value_name = _data_set_value_header
	
	_key_value_input.connect(
		"add_requested", Callable(self, "_on_add_requested"))
	_key_value_input.connect(
		"delete_requested", Callable(self, "_on_delete_requested"))


func _on_add_requested() -> void:
	_add_key_value_input()


func _on_delete_requested() -> void:
	pass
