extends Serializable
class_name Settings

var os : String
var version : String
var mediation : bool
var providers : Array[Provider]


func serialize() -> Dictionary:
	var saveable_data : Dictionary = {
		"@subpath":null, 
		"@path": _get_class_path(),
		"os" : os,
		"version" : version,
		"mediation" : mediation,
		"providers" : _get_providers()
	}
	
	return saveable_data


static func deserialize(settings_data:Dictionary) -> Serializable:
	var settings : Settings = dict_to_inst(settings_data)
	return settings


func _get_providers() -> Array[Dictionary]:
	var providers_data : Array[Dictionary]
	for provider in providers:
		providers_data.append(provider.serialize())
	
	return providers_data


func _get_class_path() -> String:
	return "res://addons/godot_android_ads/src/serializables/settings.gd"
