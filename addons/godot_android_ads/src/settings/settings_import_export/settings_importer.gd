class_name SettingsImporter

const export_path : String = "res://addons/godot_android_ads/settings.json"


static func import() -> Settings:
	
	var settings_json = FileHandler.file_read(export_path)
	
	if not settings_json.is_empty():
		var json : JSON = JSON.new()
		var err : int = json.parse(settings_json)
		if err == OK:
			var settings_data : Dictionary = json.get_data()
			
			var settings_obj : Settings = dict2inst(settings_data)
			settings_obj.providers = deserialize_provider_data(settings_data)
			
			return settings_obj
	
	return Settings.new()


static func deserialize_provider_data(settings_data: Dictionary) -> Array[Provider]:
	var provider_obj_array : Array[Provider] = []
	for provider_dict in settings_data.providers:
		provider_obj_array.append(Provider.deserialize(provider_dict))
	
	return provider_obj_array
