extends Area2D

# Will only change scene for Nodes on the player physics layer
func _on_area_entered(area):
	SceneLoader.gameScene2()
	
