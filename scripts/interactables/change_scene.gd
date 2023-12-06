extends Area2D

@export var next_scene: PackedScene

# Will only change scene for Nodes on the player physics layer
func _on_area_entered(area):
	call_deferred("change_scene")

func change_scene():
	get_tree().change_scene_to_packed(next_scene)
