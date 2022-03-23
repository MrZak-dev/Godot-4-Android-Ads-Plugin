extends Node

var settings_instance : Settings

func _init() -> void:
	_import()


func get_provider(provider_id:int) -> Provider:
	if _has_provider(provider_id):
		return settings_instance.provider_id[provider_id]
	else:
		Utils.log(Utils.LOG_TYPE.ERROR,
			"Provider data does not exist !")
		return null


# ------------------------------------------------------------------------------
# 
# ------------------------------------------------------------------------------
func add_provider(
	provider_id:int,
	enabled:bool = false,
	dependencies:Array = [],
	app_id:String = "",
	interstitial_ids:Dictionary = {},
	rewarded_ids:Dictionary = {},
	banner_ids:Dictionary = {}
	) -> void:
		
	
	if _has_provider(provider_id):
		Utils.log(Utils.LOG_TYPE.ERROR, "Provider already exists !")
		return
	
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


func remove_provider(provider_id:int) -> bool:
	if _has_provider(provider_id):
		settings_instance.providers.remove_at(provider_id)
		return true
	return false


func get_interstitial_id(provider_id:int, ad_name:String="default") -> String:
	if _has_provider(provider_id):
		if settings_instance.providers[provider_id].interstitial_ids.has(ad_name):
			return settings_instance.providers[provider_id].interstitial_ids[ad_name]
	
	Utils.log(Utils.LOG_TYPE.ERROR, ("Interstitial : %s does not exist" % ad_name))
	return ""


func get_rewarded_id(provider_id:int, ad_name:String="default") -> String:
	if _has_provider(provider_id):
		if settings_instance.providers[provider_id].rewarded_ids.has(ad_name):
			return settings_instance.providers[provider_id].rewarded_ids[ad_name]
	
	Utils.log(Utils.LOG_TYPE.ERROR, ("Rewarded : %s does not exist" % ad_name))
	return ""


func get_banner_id(provider_id:int, ad_name:String="default") -> String:
	if _has_provider(provider_id):
		if settings_instance.providers[provider_id].banner_ids.has(ad_name):
			return settings_instance.providers[provider_id].banner_ids[ad_name]
	
	Utils.log(Utils.LOG_TYPE.ERROR, ("Banner : %s does not exist" % ad_name))
	return ""


func add_interstitial_id(provider_id:int, ad_name:String, ad_id:String) -> void:
	if _has_provider(provider_id):
		if not _has_interstitial(provider_id, ad_name):
			settings_instance.providers[provider_id].interstitial_ids[ad_name] \
				= ad_id
			_export()


func add_rewarded_id(provider_id:int, ad_name:String, ad_id:String) -> void:
	if _has_provider(provider_id):
		if not _has_rewarded(provider_id, ad_name):
			settings_instance.providers[provider_id].rewarded_ids[ad_name] \
				= ad_id
			_export()


func add_banner_id(provider_id:int, ad_name:String, ad_id:String) -> void:
	if _has_provider(provider_id):
		if not _has_banner(provider_id, ad_name):
			settings_instance.providers[provider_id].banner_ids[ad_name] \
				= ad_id
			_export()


func _import() -> void:
	settings_instance = SettingsImporter.import()


func _export() -> void:
	SettingsExporter.export(settings_instance)


func _has_provider(provider_id:int) -> bool:
	return range(settings_instance.providers.size()).has(provider_id)


func _has_interstitial(provider_id:int, ad_name:String) -> bool:
	if _has_provider(provider_id):
		return settings_instance.providers[provider_id].interstitial_ids.has(ad_name)
	return false


func _has_rewarded(provider_id:int, ad_name:String) -> bool:
	if _has_provider(provider_id):
		return settings_instance.providers[provider_id].rewarded_ids.has(ad_name)
	return false


func _has_banner(provider_id:int, ad_name:String) -> bool:
	if _has_provider(provider_id):
		return settings_instance.providers[provider_id].banner_ids.has(ad_name)
	return false
