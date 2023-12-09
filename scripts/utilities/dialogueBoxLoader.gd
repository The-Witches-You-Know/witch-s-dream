extends Node

class_name DialogueBoxLoader
static var dialogueHandler: DialogueHandler

# Called when the node enters the scene tree for the first time.
func _ready():
	var node = ResourceLoader.load("res://packedscenes/dialogue_box.tscn")
	dialogueHandler = node.instantiate()
	add_child(dialogueHandler)

func open(dialogueTreeName, openingLineIndex):
	dialogueHandler.openDialogueBox(dialogueTreeName, openingLineIndex)
	
func getVisible():
	return dialogueHandler.visible

