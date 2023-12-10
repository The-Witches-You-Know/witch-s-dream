extends Sprite2D

@onready var pauseMenuContent = $PauseMenuContent
@onready var settingsMenuContent = $SettingsMenuContent


func _ready():
	get_tree().paused = true

func _on_continue_button_pressed():
	get_tree().paused = false
	self.visible = false
	Cursor.hide()

func _on_settings_button_pressed():
	pauseMenuContent.visible = false
	settingsMenuContent.visible = true

func _on_main_menu_button_pressed():	
	pass
