extends Control

@export var starting_scene: PackedScene

func _on_newgame_button():
	SaveFile.clearFile()
	get_tree().change_scene_to_packed(starting_scene)
	
func _on_contiue_button():
	get_tree().change_scene_to_packed(starting_scene)
