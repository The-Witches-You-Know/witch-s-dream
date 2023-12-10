extends Node

class_name SettingsFile

static var config = ConfigFile.new()
static var settingsData = {}

func _ready():
	SettingsFile.loadFile()

# this function reads all the saved data, and clears the save file if it has been altered or corrupted.
static func loadFile():
	var err = config.load("user://settingsfile.cfg")
	if err == OK:
		var entryKeys = config.get_value("settings", "entry_keys", [])
		for entry in entryKeys:
			settingsData[entry] = config.get_value("settings", entry, null)
	onSettingsLoad()

# this function saves all the data that needs to be saved and calculates a checksum to avoid savescumming
static func saveFile():
	for key in settingsData.keys():
		config.set_value("settings", key, settingsData[key])
	if (len(settingsData.keys()) > 0):
		config.set_value("settings", "entry_keys", settingsData.keys())
	config.save("user://settingsfile.cfg")
	


static func onSettingsLoad():
	setMasterVolume(safeGet("MasterVolume", 10))
	setMusicVolume(safeGet("MusicVolume", 10))
	setSFXVolume(safeGet("SFXVolume", 10))

static func setMasterVolume(value: float):
	var busIndex = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(busIndex, -80 + (8 * value))
	AudioServer.set_bus_mute(busIndex, value == 0)
	
static func setMusicVolume(value: float):
	var busIndex = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(busIndex, -80 + (8 * value))
	AudioServer.set_bus_mute(busIndex, value == 0)
	
static func setSFXVolume(value: float):
	var busIndex = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(busIndex, -80 + (8 * value))
	AudioServer.set_bus_mute(busIndex, value == 0)
	print()

# Use this function to set any new value into the save file
static func setOrPut(key, value):
	SettingsFile.settingsData[key] = value
	SettingsFile.saveFile()
	
# Use this function to safely retrieve any value from the save file.
# Supply a default value in case info cannot be found.
static func safeGet(key, defaultValue):
	if settingsData != null and settingsData.has(key):
		return settingsData[key]
	return defaultValue
	
static func clearFile():
	settingsData = {}
	saveFile()
