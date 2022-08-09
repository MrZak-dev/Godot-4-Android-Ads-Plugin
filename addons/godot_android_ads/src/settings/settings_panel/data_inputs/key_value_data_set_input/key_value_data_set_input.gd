@tool
extends PanelContainer
class_name KeyValueDataSetInput


const _input_scn : PackedScene = preload(
	"res://addons/godot_android_ads/src/settings/settings_panel/data_inputs/key_value_data_edit/key_value_removable/KeyValueRemovableEdit.tscn")

@export_node_path(VBoxContainer) var _inputs_container_path
@export var _data_set_header : String
@export var _data_set_key_header : String
@export var _data_set_value_header : String

var data:Dictionary:
	set(value):
		data = value

@onready var _inputs_container : VBoxContainer = get_node(
	_inputs_container_path)
@onready var _set_header_lbl : Label = get_node("%Header")


func _ready() -> void:
	_set_inputs_container_signals()
	_set_header_text()
	
	set_data({
		"default" : "ca-app-pub-123",
		"home" : "ca-app-pub-456",
	})


func get_data() -> Dictionary:
	return data


func set_data(data:Dictionary) -> void:
	for i in data.size():
		_add_key_value_input(data.keys()[i], data.values()[i])
	
	if data.size() == 0 and _inputs_container.get_child_count() == 0:
		_add_key_value_input()
	
	self.data = data


func update_data() -> void:
	await get_tree().process_frame # wait for children to be added and removed
	var data : Dictionary = {}
	for c in _inputs_container.get_children():
		var _c : KeyValueEdit = c
		
		if not _c.is_filled():
			continue
		
		if data.keys().has(_c.get_key()):
			_c.set_invalid()
			continue
		
		data[_c.get_key()] = _c.get_value()
	
	self.data = data


func _set_inputs_container_signals() -> void:
	_inputs_container.child_exiting_tree.connect(
		Callable(self, "_on_input_add"))
	_inputs_container.child_exiting_tree.connect(
		Callable(self, "_on_input_deleted"))


func _set_header_text() -> void:
	_set_header_lbl.set_text(_data_set_header)


func _add_key_value_input(key_data := "", value_data := "") -> void:
	var key_value_input : KeyValueRemovableEdit = _input_scn.instantiate()
	_inputs_container.add_child(key_value_input)
	
	key_value_input.key_name = _data_set_key_header
	key_value_input.value_name = _data_set_value_header
	
	key_value_input.add_requested.connect(
		Callable(self, "_on_add_requested"))
	key_value_input.delete_requested.connect(
		Callable(self, "_on_delete_requested"))
	key_value_input.data_submitted.connect(
		Callable(self, "_on_input_data_submitted"))
	
	key_value_input.set_key(key_data)
	key_value_input.set_value(value_data)
	
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


func _on_delete_requested(key:String) -> void:
	data.erase(key)
	_set_buttons_visibility()


func _on_input_add(input: Node) -> void:
	_set_buttons_visibility()


func _on_input_deleted(input: Node) -> void:
	_set_buttons_visibility()


func _on_input_data_submitted(input_data:Dictionary, edit:KeyValueEdit) -> void:
	await update_data()
	
	print(get_data())
