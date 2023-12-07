extends Node


var floatingPickupText: MyFloatingPickupText

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = ResourceLoader.load("res://packedscenes/FloatingPickupText.tscn")
	floatingPickupText = node.instantiate()
	add_child(floatingPickupText)
