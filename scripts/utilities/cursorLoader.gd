extends Node

class_name CursorLoader
static var cursor: CursorNode

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = ResourceLoader.load("res://packedscenes/Menu/cursor.tscn")
	cursor = node.instantiate()
	add_child(cursor)

func show():
	cursor.visible = true
	
func hide():
	cursor.visible = false

