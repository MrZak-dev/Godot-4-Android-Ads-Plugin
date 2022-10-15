class_name FileHandler


## Read from a file 
static func file_read(path:String) -> String:
	if FileAccess.file_exists(path):
		
		var file = FileAccess.open(path, FileAccess.READ)
		var file_text = file.get_as_text()
		file = null
		
		return file_text
	
	Utils.log(Utils.LOG_TYPE.NOT_FOUND, "settings.json file is missing")
	return ""


## Save text to a file (overwrite existing text)
static func file_write(path:String, text:String) -> void:
	var file_rw : FileAccess = FileAccess.new()
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(text)
	file = null
