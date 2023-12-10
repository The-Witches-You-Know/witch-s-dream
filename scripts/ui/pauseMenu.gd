extends Sprite2D

class_name PauseMenu

@onready var pauseMenuContent = $PauseMenuContent
@onready var settingsMenuContent = $SettingsMenuContent

@onready var masterVolumeSlider: HSlider = $SettingsMenuContent/VBoxContainer/SliderContainer/MasterVolumeSlider
@onready var musicVolumeSlider: HSlider = $SettingsMenuContent/VBoxContainer/SliderContainer2/MusicVolumeSlider
@onready var sfxVolumeSlider: HSlider = $SettingsMenuContent/VBoxContainer/SliderContainer3/SFXVolumeSlider

func open():
	pauseMenuContent.visible = true
	settingsMenuContent.visible = false
	get_tree().paused = true
	visible = true
	Cursor.show()
	masterVolumeSlider.value = SettingsFile.safeGet("MasterVolume",10)
	musicVolumeSlider.value = SettingsFile.safeGet("MusicVolume",10)
	sfxVolumeSlider.value = SettingsFile.safeGet("SFXVolume",10)

func _input(ev):
	if ev is InputEventKey and ev.keycode == KEY_ESCAPE and ev.pressed && get_tree().paused:
		if (settingsMenuContent.visible):
			_on_return_button_pressed()
		else:
			get_viewport().set_input_as_handled()
			_on_continue_button_pressed()

func _on_continue_button_pressed():
	get_tree().paused = false
	visible = false
	Cursor.hide()

func _on_settings_button_pressed():
	pauseMenuContent.visible = false
	settingsMenuContent.visible = true

func _on_main_menu_button_pressed():	
	SceneLoader.menuScene()


func _on_master_volume_slider_value_changed(value):
	var busIndex = AudioServer.get_bus_index("Master")
	SettingsFile.setMasterVolume(value)

func _on_music_volume_slider_value_changed(value):
	var busIndex = AudioServer.get_bus_index("Music")
	SettingsFile.setMusicVolume(value)

func _on_sfx_volume_slider_value_changed(value):
	SettingsFile.setOrPut("SFXVolume",value)
	SettingsFile.setSFXVolume(value)

func _on_return_button_pressed():	
	settingsMenuContent.visible = false
	pauseMenuContent.visible = true
