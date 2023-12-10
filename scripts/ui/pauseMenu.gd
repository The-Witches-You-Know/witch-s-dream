extends Sprite2D

class_name PauseMenu

@onready var pauseMenuContent = $PauseMenuContent
@onready var settingsMenuContent = $SettingsMenuContent

func open():
	get_tree().paused = true
	visible = true
	Cursor.show()
	

func _on_continue_button_pressed():
	get_tree().paused = false
	visible = false
	Cursor.hide()

func _on_settings_button_pressed():
	pauseMenuContent.visible = false
	settingsMenuContent.visible = true

func _on_main_menu_button_pressed():	
	SceneLoader.menuScene()
