extends Resource
class_name Serializable

# ------------------------------------------------------------------------------
# Virtual to Override
# Convert Serializable class object to json data
# ------------------------------------------------------------------------------
func serialize() -> Dictionary:
	assert(false, "Should be overriden")
	return {}


func _get_class_path() -> String:
	assert(false, "Should be overriden")
	return ""


# ------------------------------------------------------------------------------
# Virtual to Override
# Convert a json data to Serializable class object
# ------------------------------------------------------------------------------ 
static func deserialize(data:Dictionary) -> Serializable:
	assert(false, "Should be overriden")
	return Serializable.new()
