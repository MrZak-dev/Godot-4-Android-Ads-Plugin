@tool
extends EditorPlugin

const AndroidAdsLibPath : String = \
	"res://addons/godot_android_ads/plugin_lib.gd"
const SettingsHandler : String = \
	"res://addons/godot_android_ads/src/settings/SettingsHandler.gd"
const SettingPanel : PackedScene = \
	preload("res://addons/godot_android_ads/src/settings/settings_panel/settings_panel.tscn")

var settings_panel_instance

func _enter_tree() -> void:
	add_autoload_singleton("AndroidAds", AndroidAdsLibPath)
	add_autoload_singleton("SettingsHandler", SettingsHandler)
	_set_settings_panel()


func _exit_tree() -> void:
	if settings_panel_instance:
		settings_panel_instance.queue_free()


func _get_plugin_name() -> String:
	return "Android Ads"



func _handles(object) -> bool:
	return true


func _set_settings_panel() -> void:
	settings_panel_instance = SettingPanel.instantiate()
	add_control_to_bottom_panel(settings_panel_instance, _get_plugin_name())
