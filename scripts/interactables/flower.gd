@tool
extends Interactable

class_name Flower

@export var pickedFlowerSprite: Texture2D

# load save data. If flower has been picked, disable it.
func onReady():
	if (SaveFile.safeGet(self.identifier+".canInteract", true) == false):
		$Area2D/Sprite.texture = pickedFlowerSprite
		self.canInteract = false;
		

# Flower gets picked, adds 1 flower to inventory and disables self
func onInteractionTrigger(player):
	player.addToInventory(
		"Flower",
		1
	)
	SaveFile.setOrPut(self.identifier+".canInteract", false)
	$Area2D/Sprite.texture = pickedFlowerSprite
	self.canInteract = false;
