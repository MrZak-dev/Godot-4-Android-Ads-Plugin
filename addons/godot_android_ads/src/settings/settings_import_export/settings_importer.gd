class_name SettingsImporter

const settings_path : String = "res://addons/godot_android_ads/settings.json"


static func import() -> Settings:
	
	var settings_json = FileHandler.file_read(settings_path)
	
	if not settings_json.is_empty():
		var json : JSON = JSON.new()
		var err : int = json.parse(settings_json)
		if err == OK:
			var settings_data : Dictionary = json.get_data()
			
			var settings_obj : Settings = Settings.deserialize(settings_data)
			settings_obj.providers = deserialize_provider_data(settings_data)
			
			Utils.log(Utils.LOG_TYPE.INFO, "settings imported successfully")
			return settings_obj
	
	Utils.log(Utils.LOG_TYPE.ERROR, "settings import failed")
	return Settings.new()


static func deserialize_provider_data(settings_data: Dictionary) -> Array[Serializable]:
	var provider_obj_array := [] # TODO : Check if this can be typed as Array[Provider]
	for provider_dict in settings_data.providers:
		provider_obj_array.append(Provider.deserialize(provider_dict))
	
	return provider_obj_array as Array[Provider]
