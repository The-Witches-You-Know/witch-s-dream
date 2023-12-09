extends CanvasLayer

@export var starting_scene: PackedScene

func _ready():
	$confirm_popup.visible = false

func _on_newgame_button():
	$confirm_popup.visible = true
	
func _on_contiue_button():
	open_starting_scene()

func _on_popup_response(response):
	if(response):
		SaveFile.clearFile()
		open_starting_scene()
	
	$confirm_popup.visible = false
	
func open_starting_scene():
	Cursor.hide()
	get_tree().change_scene_to_packed(starting_scene)
	
