extends Serializable
class_name Provider

var provider_id : int
var enabled : bool
var dependencies : Array[String]
var app_id : String
var interstitial_id : String
var rewarded_id : String
var banner_id : String


func serialize() -> Dictionary:
	var provider_data : Dictionary = {
		"provider_id" : provider_id,
		"enabled" : enabled,
		"dependencies" : _get_dependencies(),
		"app_id" : app_id,
		"interstitial_id" : interstitial_id,
		"rewarded_id" : rewarded_id,
		"banner_id" : banner_id
	}
	
	return provider_data


func _get_dependencies() -> Array[String]:
	var dependencies_data : Array[String]
	for dependency in dependencies:
		dependencies_data.append(dependency)
	
	return dependencies_data
