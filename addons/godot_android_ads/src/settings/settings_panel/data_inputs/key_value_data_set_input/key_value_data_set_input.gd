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
	_set_inputs_container_signals()
	_add_key_value_input()
	_set_header_text()


func _set_inputs_container_signals() -> void:
	_inputs_container.connect(
		"child_entered_tree", Callable(self, "_on_input_add"))
	_inputs_container.connect(
		"child_exited_tree", Callable(self, "_on_input_deleted"))


func _set_header_text() -> void:
	_set_header_lbl.set_text(_data_set_header)


func _add_key_value_input() -> void:
	var key_value_input : KeyValueRemovableEdit = _input_scn.instantiate()
	_inputs_container.add_child(key_value_input)
	
	key_value_input.key_name = _data_set_key_header
	key_value_input.value_name = _data_set_value_header
	
	key_value_input.connect(
		"add_requested", Callable(self, "_on_add_requested"))
	key_value_input.connect(
		"delete_requested", Callable(self, "_on_delete_requested"))
	
	_set_buttons_visibility()


func _set_buttons_visibility() -> void:
	await get_tree().process_frame # wait for children to be added and removed 
	
	var inputs_count : int = _inputs_container.get_child_count()
	
	var first_input : KeyValueRemovableEdit = _inputs_container.get_child(0)
	var last_input : KeyValueRemovableEdit = _inputs_container.get_child(inputs_count - 1)
	
	first_input.add_button_visibility(inputs_count == 1)
	first_input.delete_button_visibility(false)
	
	for i in inputs_count - 1:
		_inputs_container.get_child(i).add_button_visibility(false)
	
	last_input.add_button_visibility(true)


func _on_add_requested() -> void:
	_add_key_value_input()


func _on_delete_requested() -> void:
	_set_buttons_visibility()


func _on_input_add(input: Node) -> void:
	_set_buttons_visibility()


func _on_input_deleted(input: Node) -> void:
	_set_buttons_visibility()
