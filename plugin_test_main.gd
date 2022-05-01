extends Node


func _ready() -> void:
	AndroidAds.connect("log_message", Callable(self, "on_log_message"))
	var ad_id = SettingsHandler.get_interstitial_id(
		AndroidAds.AdsProvider.ADMOB, "default")
	
	print(ad_id)


func _on_emit_signal_pressed() -> void:
	AndroidAds._test_plugin()


func on_log_message(message:String) -> void:
	print(message)


func _on_init_admob_btn_pressed() -> void:
	AndroidAds.initialize_admob()


func _on_load_admob_interstitial_pressed() -> void:
	AndroidAds.load_admob_interstitial("default")


func _on_show_admob_interstitial_pressed() -> void:
	AndroidAds.show_admob_interstitial("default")


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
	
