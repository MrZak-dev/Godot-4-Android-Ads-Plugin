extends Node

var settings_instance : Settings

func _init() -> void:
	_import()


func get_provider(provider_id:int) -> Provider:
	if range(settings_instance.providers.size()).has(provider_id):
		return settings_instance.provider_id[provider_id]
	else:
		AndroidAds.emit_signal("_log_typed_message", 0,
			"ERROR :Provider data does not exist !")
		return null


func add_provider(
	provider_id:int,
	enabled:bool = false,
	dependencies:Array = [],
	app_id:String = "",
	interstitial_ids:Dictionary = {},
	rewarded_ids:Dictionary = {},
	banner_ids:Dictionary = {}
	) -> void:
	
	var provider_data : Dictionary = {
		"provider_id" : provider_id,
		"enabled" : enabled,
		"dependencies" : dependencies,
		"app_id" : app_id,
		"interstitial_ids" : interstitial_ids,
		"rewarded_ids" : rewarded_ids,
		"banner_ids" : banner_ids
	}
	
	var provider : Provider = Provider.new()
	provider.create_from_dict(provider_data)
	settings_instance.providers.insert(provider_id, provider)
	
	_export()


func remove_provider() -> bool:
	return false


func _import() -> void:
	settings_instance = SettingsImporter.import()


func _export() -> void:
	SettingsExporter.export(settings_instance)

