@tool
class_name Utils

enum LOG_TYPE {
	WARNING = 0,
	ERROR,
	NOT_FOUND,
	INFO,
}

const LOG_TYPE_VALUES : Array[String] = [
	"WARNING",
	"ERROR",
	"NOT FOUND",
	"INFO",
]

const is_debug : bool = true


static func log(type:LOG_TYPE, message:String) -> void:
	
	if not is_debug:
		return
	
	var log_message : String = "ADS Plugin %s : %s" % [LOG_TYPE_VALUES[type], message]
	
	match type:
		LOG_TYPE.ERROR:
			printerr(log_message)
		LOG_TYPE.WARNING:
			printerr(log_message)
		LOG_TYPE.NOT_FOUND:
			printerr(log_message)
		LOG_TYPE.INFO:
			print(log_message)
		_:
			print(log_message)
