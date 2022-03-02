extends Node
class_name SettingsExporter

const export_path : String = "res://addons/godot_android_ads/settings.json"


static func export(settings: Settings) -> void:
	
	var json : JSON = JSON.new()
	var settings_data : Dictionary = settings.serialize()
	var settings_json : String = json.stringify(settings_data, "\t")
	
	FileHandler.file_write(export_path, settings_json)
