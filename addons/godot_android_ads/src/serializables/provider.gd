extends Serializable
class_name Provider

var provider_id : int
var enabled : bool
var dependencies : Array[String]
var app_id : String
var interstitial_ids : Dictionary
var rewarded_ids : Dictionary
var banner_ids : Dictionary


func serialize() -> Dictionary:
	var provider_data : Dictionary = {
		"@subpath":null,
		"@path": _get_class_path(),
		"provider_id" : provider_id,
		"enabled" : enabled,
		"dependencies" : _get_dependencies(),
		"app_id" : app_id,
		"interstitial_ids" : interstitial_ids,
		"rewarded_ids" : rewarded_ids,
		"banner_ids" : banner_ids
	}
	
	return provider_data


func create_from_dict(data:Dictionary) -> void:
	data["@subpath"] = null
	data["@path"] = _get_class_path()
	
	for property in data.keys():
		set(property, data[property])


static func deserialize(provider_data:Dictionary) -> Serializable:
	var provider : Provider = dict_to_inst(provider_data) as Provider
	return provider


func _get_dependencies() -> Array[String]:
	var dependencies_data : Array[String]
	for dependency in dependencies:
		dependencies_data.append(dependency)
	
	return dependencies_data


func _get_class_path() -> String:
	return "res://addons/godot_android_ads/src/serializables/provider.gd"
