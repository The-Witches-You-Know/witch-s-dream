class_name SaveFile

static var config = ConfigFile.new()
static var saveData = {}

# this function reads all the saved data, and clears the save file if it has been altered or corrupted.
static func loadFile():
	var err = config.load("user://savefile.cfg")
	if err == OK:
		var entryKeys = config.get_value("savefile", "entry_keys", [])
		for entry in entryKeys:
			saveData[entry] = config.get_value("savefile", entry, null)
		var checksum = config.get_value("savefile", "checksum", "")
		if (checksum != calculateChecksum(saveData)):
			saveData = []
			saveFile()

# this function saves all the data that needs to be saved and calculates a checksum to avoid savescumming
static func saveFile():
	for key in saveData.keys():
		config.set_value("savefile", key, saveData[key])
	if (len(saveData.keys()) > 0):
		config.set_value("savefile", "entry_keys", saveData.keys())
		config.set_value("savefile", "checksum", calculateChecksum(saveData))
	config.save("user://savefile.cfg")
	
static func calculateChecksum(saveData):
	return JSON.stringify(saveData).md5_text()
	
