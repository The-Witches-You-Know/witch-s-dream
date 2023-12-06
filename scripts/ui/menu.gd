extends Control

func _on_newgame_button():
	SaveFile.clearFile()
	get_tree().change_scene_to_file("res://Main.tscn")
	
func _on_contiue_button():
	get_tree().change_scene_to_file("res://Main.tscn")
