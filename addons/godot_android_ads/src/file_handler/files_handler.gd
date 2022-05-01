class_name FileHandler


## Read from a file 
static func file_read(path:String) -> String:
	var file_rw : File = File.new()
	
	if file_rw.file_exists(path):
		
		file_rw.open(path, File.READ)
		var file_text = file_rw.get_as_text()
		file_rw.close() 
		
		return file_text
	
	Utils.log(Utils.LOG_TYPE.NOT_FOUND, "settings.json file is missing")
	return ""


## Save text to a file (overwrite existing text)
static func file_write(path:String, text:String) -> void:
	var file_rw : File = File.new()
	
	file_rw.open(path, File.WRITE)
	file_rw.store_string(text)
	file_rw.close()
