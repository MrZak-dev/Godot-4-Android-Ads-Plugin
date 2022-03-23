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


static func log(type:LOG_TYPE, message:String) -> void:
	var log_message : String = "ADS Plugin %s : %s" % [LOG_TYPE_VALUES[type], message]
	if type == LOG_TYPE.ERROR:
		push_error(log_message)
	else:
		push_warning(log_message)
