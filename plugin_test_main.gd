extends Node


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
	AndroidAds.load_admob_rewarded("default")


func _on_show_admob_rewarded_pressed() -> void:
	AndroidAds.show_admob_rewarded("default")


func _on_load_admob_banner_pressed() -> void:
	AndroidAds.load_admob_banner("default",
		AndroidAds.AdmobBannerSize.LARGE_BANNER)


func _on_show_admob_banner_pressed() -> void:
	AndroidAds.show_admob_banner("default", false)


func _on_hide_admob_banner_pressed() -> void:
	AndroidAds.hide_admob_banner()


func _on_load_admob_interstitial_home_pressed() -> void:
	AndroidAds.load_admob_interstitial("home")


func _on_show_admob_interstitial_home_pressed() -> void:
	AndroidAds.show_admob_interstitial("home")


func _on_load_admob_rewarded_home_pressed() -> void:
	AndroidAds.load_admob_rewarded("home")


func _on_show_admob_rewarded_home_pressed() -> void:
	AndroidAds.show_admob_rewarded("home")


func _on_load_admob_banner_home_pressed() -> void:
	AndroidAds.load_admob_banner("home",
		AndroidAds.AdmobBannerSize.LARGE_BANNER)


func _on_show_admob_banner_home_pressed() -> void:
	AndroidAds.show_admob_banner("home", true)
