extends Node2D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
func _process(delta):
	self.global_position = get_viewport().get_mouse_position()
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		$AnimationPlayer.play("click")
