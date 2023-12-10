extends Node

class_name CursorLoader
static var cursor: CursorNode

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = ResourceLoader.load("res://packedscenes/Menu/cursor.tscn")
	cursor = node.instantiate()
	add_child(cursor)

func show():
	create_tween().tween_property(cursor.sprite, "modulate", Color(1.0,1.0,1.0,1.0), 0.15)
	
func hide():
	create_tween().tween_property(cursor.sprite, "modulate", Color(1.0,1.0,1.0,0.0), 0.5)

