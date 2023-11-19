extends Interactable

class_name Flower

@export var pickedFlowerSprite: Texture2D

#randomizes the amount of "flower" picked up
var flowerQuantityRange = [1.0, 1.0]

func onReady():
	if (SaveFile.safeGet(self.identifier+".canInteract", true) == false):
		$Area2D/Sprite.texture = pickedFlowerSprite
		self.canInteract = false;
	else:
		self.canInteract = true;
		

# Flower gets picked
func onInteractionTrigger(player):
	print(self.identifier)
	player.addToInventory(
		"Flower",
		randf_range(flowerQuantityRange[1], flowerQuantityRange[1])
	)
	SaveFile.setOrPut(self.identifier+".canInteract", false)
	$Area2D/Sprite.texture = pickedFlowerSprite
	self.canInteract = false;
