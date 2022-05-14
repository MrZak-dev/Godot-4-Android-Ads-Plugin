@tool
extends KeyValueEdit
class_name KeyValueRemovableEdit

@export_node_path(VBoxContainer) var parent_path : NodePath

var _parent_node : VBoxContainer

@onready var _add_btn : Button = get_node("%AddButton")
@onready var _delete_btn : Button = get_node("%DeleteButton")


func _ready() -> void:
	super._ready()
	_parent_node = get_node(parent_path)


func _on_add() -> void:
	pass


func _on_remove() -> void:
	pass


func _exit_tree() -> void:
	emit_signal("data_submitted")


func _set_signals() -> void:
	super._set_signals()
	
	_add_btn.connect("pressed", Callable(self, "_on_add"))
	_delete_btn.connect("pressed", Callable(self, "_on_remove"))
