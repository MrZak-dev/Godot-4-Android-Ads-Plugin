@tool
extends KeyValueEdit
class_name KeyValueRemovableEdit

signal add_requested
signal delete_requested(key:String)

@onready var _add_btn : TextureButton = get_node("%AddButton")
@onready var _delete_btn : TextureButton = get_node("%DeleteButton")


func _ready() -> void:
	super._ready()


func add_button_visibility(_visible:bool) -> void:
	_add_btn.get_parent().set_visible(_visible)


func delete_button_visibility(_visible:bool) -> void:
	_delete_btn.get_parent().set_visible(_visible)


func _on_add() -> void:
	add_requested.emit()


func _on_remove() -> void:
	if is_filled():
		delete_requested.emit(get_key())
	queue_free()


func _set_signals() -> void:
	super._set_signals()
	
	_add_btn.pressed.connect(Callable(self, "_on_add"))
	_delete_btn.pressed.connect(Callable(self, "_on_remove"))
