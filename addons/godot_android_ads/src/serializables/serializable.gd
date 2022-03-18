extends Node
class_name Serializable

# Virtual
func serialize() -> Dictionary:
	assert(false, "Should be overriden")
	return {}

func _get_class_path() -> String:
	assert(false, "Should be overriden")
	return ""

# Virtual 
static func deserialize(data:Dictionary) -> Serializable:
	assert(false, "Should be overriden")
	return Serializable.new()
