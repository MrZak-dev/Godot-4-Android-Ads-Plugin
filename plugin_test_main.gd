extends Node
#var settings_class = preload("res://addons/godot_android_ads/src/settings.gd")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AndroidAds.connect("log_message", Callable(self, "on_log_message"))
	
	SettingsHandler.add_provider(1)
	SettingsHandler.add_interstitial_id(AndroidAds.AdsProvider.ADMOB,"game","game_id")
	var _id = SettingsHandler.get_interstitial_id(AndroidAds.AdsProvider.ADMOB,"d")
	pass


func _on_emit_signal_pressed() -> void:
	AndroidAds._test_plugin()

func on_log_message(message:String) -> void:
	print(message)


func _on_init_admob_btn_pressed() -> void:
	AndroidAds.initialize_admob()


func _on_load_admob_interstitial_pressed() -> void:
	AndroidAds.load_admob_interstitial("ca-app-pub-3940256099942544/1033173712")


func _on_show_admob_interstitial_pressed() -> void:
	AndroidAds.show_admob_interstitial()


func _on_load_admob_rewarded_pressed() -> void:
	AndroidAds.load_admob_rewarded("ca-app-pub-3940256099942544/5224354917")


func _on_show_admob_rewarded_pressed() -> void:
	AndroidAds.show_admob_rewarded()


func _on_load_admob_banner_pressed() -> void:
	AndroidAds.load_admob_banner(
		"ca-app-pub-3940256099942544/6300978111",
		AndroidAds.AdmobBannerSize.LARGE_BANNER)


func _on_show_admob_banner_pressed() -> void:
	AndroidAds.show_admob_banner()


func _on_hide_admob_banner_pressed() -> void:
	AndroidAds.hide_admob_banner()
	
