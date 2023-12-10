extends Node

@onready var pauseMenu: PauseMenu = $PauseMenu

func _input(ev):
	if ev is InputEventKey and ev.keycode == KEY_ESCAPE and ev.pressed && !get_tree().paused:
		pauseMenu.open()
