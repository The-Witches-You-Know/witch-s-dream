extends Area2D

@export var next_scene: PackedScene

func _on_area_entered(area):
	if(area.is_in_group("player")):
		get_tree().change_scene_to_packed(next_scene)
