extends Node

# Interstitial signals
signal interstitial_loaded(provider:int)
signal interstitial_failed_to_load(provider:int, error_code:int,
	erro_message:String)
signal interstitial_opened(provider:int)
signal interstitial_closed(provider:int)
# Rewarded signals
signal rewarded_loaded(provider:int)
signal rewarded_failed_to_load(provider:int, error_code:int,
	erro_message:String)
signal rewarded_opened(provider:int)
signal rewarded_closed(provider:int)
signal reward(provider:int, type:String, amount:int)
# General plugin signals
signal log_message(message:String)
signal _log_typed_message(type:int, message:String)

enum AdsProvider {
	ADMOB = 0,
	UNITY,
	APPLOVIN,
}

enum AdmobBannerSize {
	BANNER = 0, # 320x50 Phones and Tablets 
	LARGE_BANNER, # 320x100 Phones and Tablets
}

var _settings : Settings
var _java_singleton : Object
var _is_admob_interstitial_loaded : bool = false
var _is_admob_rewarded_loaded : bool = false
var _is_admob_banner_loaded : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_init_singleton()


func _test_plugin() -> void:
	if _java_singleton == null : return
	_java_singleton.testPlugin()


### Admob ads ### 
func initialize_admob() -> void:
	if _java_singleton == null : return
	_java_singleton.initializeAdmob()


func load_admob_interstitial(ad_id:String) -> void:
	if _java_singleton == null : return
	_java_singleton.loadAdmobInterstitial(ad_id)


func show_admob_interstitial() -> void:
	if _java_singleton == null : return
	_java_singleton.showAdmobInterstitial()


func load_admob_rewarded(ad_id:String) -> void:
	if _java_singleton == null : return
	_java_singleton.loadAdmobRewarded(ad_id)


func show_admob_rewarded() -> void:
	if _java_singleton == null : return
	_java_singleton.showAdmobRewarded()


func load_admob_banner(
	ad_id : String,
	ad_size : AdmobBannerSize = AdmobBannerSize.BANNER,
	is_on_top=false) -> void:
	
	if _java_singleton == null : return
	_java_singleton.loadAdmobBanner(ad_id, ad_size, is_on_top)


func show_admob_banner() -> void:
	if _java_singleton == null : return
	_java_singleton.showAdmobBanner()


func hide_admob_banner() -> void:
	if _java_singleton == null : return
	_java_singleton.hideAdmobBanner()


### Admob Ads End ###


func _connect_signals() -> void:
	if _java_singleton == null : return
	
	if not _java_singleton.is_connected(
		"_on_log_message",
		Callable(self, "_on_log_message_send")):
			_connect_interstitial_signals()
			_connect_rewarded_signals()
			_connect_banner_signals()


## Plugin signals 
func _on_interstitial_loaded(provider:int) -> void:
	_set_interstitial_load_status(provider, true)
	print("interstitial loaded " + str(provider))


func _on_interstitial_failed_to_load(provider:int, error_code:int,
	erro_message:String) -> void:
	print("_on_interstitial_failed_to_load " + str(provider) + erro_message)


func _on_interstitial_opened(provider:int) -> void:
	_set_interstitial_load_status(provider, false)
	print("_on_interstitial_opened " + str(provider))


func _on_interstitial_closed(provider:int) -> void:
	print("_on_interstitial_closed " + str(provider))


func _on_rewarded_loaded(provider:int) -> void:
	_set_rewarded_load_status(provider, true)
	print("_on_rewarded_loaded " + str(provider))


func _on_rewarded_failed_to_load(provider:int, error_code:int,
	erro_message:String) -> void:
	print("_on_rewarded_failed_to_load " + str(provider) + erro_message)


func _on_rewarded_opened(provider:int) -> void:
	_set_rewarded_load_status(provider, false)
	print("_on_rewarded_opened " + str(provider))


func _on_rewarded_closed(provider:int) -> void:
	print("_on_rewarded_closed " + str(provider))


func _on_reward(provider:int, type:String, amount:int) -> void:
	print("_on_reward " + type + str(provider))


func _on_banner_loaded(provider:int) -> void:
	print("_on_banner_loaded " + str(provider))


func _on_banner_failed_to_load(provider:int, error_code:int,
	erro_message:String) -> void:
	print("_on_banner_failed_to_load " + str(provider) + erro_message)


func _on_log_message_send(message:String) -> void:
	print(message)


func _init_singleton() -> bool:
	if Engine.has_singleton("GodotAndroidAds"):
		_java_singleton = Engine.get_singleton("GodotAndroidAds")
		_connect_signals()
		return true
	return false


func _connect_interstitial_signals() -> void:
	_java_singleton.connect(
		"_on_log_message",
		Callable(self, "_on_log_message_send"))
	_java_singleton.connect(
		"_on_interstitial_loaded",
		Callable(self, "_on_interstitial_loaded"))
	_java_singleton.connect(
		"_on_interstitial_failed_to_load",
		Callable(self, "_on_interstitial_failed_to_load"))
	_java_singleton.connect(
		"_on_interstitial_opened",
		Callable(self, "_on_interstitial_opened")
	)
	_java_singleton.connect(
		"_on_interstitial_closed",
		Callable(self, "_on_interstitial_closed")
	)


func _connect_rewarded_signals() -> void:
	_java_singleton.connect(
		"_on_rewarded_loaded",
		Callable(self, "_on_rewarded_loaded"))
	_java_singleton.connect(
		"_on_rewarded_failed_to_load",
		Callable(self, "_on_rewarded_failed_to_load"))
	_java_singleton.connect(
		"_on_rewarded_opened",
		Callable(self, "_on_rewarded_opened")
	)
	_java_singleton.connect(
		"_on_rewarded_closed",
		Callable(self, "_on_rewarded_closed")
	)
	_java_singleton.connect(
		"_on_reward",
		Callable(self, "_on_reward")
	)


func _connect_banner_signals() -> void:
	_java_singleton.connect(
		"_on_banner_loaded",
		Callable(self, "_on_banner_loaded"))
	_java_singleton.connect(
		"_on_banner_failed_to_load",
		Callable(self, "_on_banner_failed_to_load"))


func _set_interstitial_load_status(provider:int, status:bool) -> void:
	match provider:
		AdsProvider.ADMOB:
			_is_admob_interstitial_loaded = status
		_:
			emit_signal("log_message",
				"_set_interstitial_load_status : NO GIVEN ADS PROVIDER ")


func _set_rewarded_load_status(provider:int, status:bool) -> void:
	match provider:
		AdsProvider.ADMOB:
			_is_admob_rewarded_loaded = status
		_:
			emit_signal("log_message",
				"_set_rewarded_load_status : NO GIVEN ADS PROVIDER ")
