extends Serializable
class_name Settings

var os : String
var version : String
var mediation : bool
var providers : Array[Provider]


func serialize() -> Dictionary:
	var saveable_data : Dictionary = {
		"@subpath":null, 
		"@path":"res://addons/godot_android_ads/src/serializables/settings.gd",
		"os" : os,
		"version" : version,
		"mediation" : mediation,
		"providers" : _get_providers()
	}
	
	return saveable_data


func _get_providers() -> Array[Dictionary]:
	var providers_data : Array[Dictionary]
	for provider in providers:
		providers_data.append(provider.serialize())
	
	return providers_data
