extends Interactable

class_name Flower

@export var pickedFlowerSprite: Texture2D

#randomizes the amount of "flower" picked up
var flowerQuantityRange = [1.0, 1.0]

func onReady():
	if (SaveFile.saveData.has(self.identifier+".canInteract")):
		if (SaveFile.saveData[self.identifier+".canInteract"] == false):
			$Area2D/Sprite.texture = pickedFlowerSprite
			$Collider.shape = null

# Flower gets picked
func onInteractionTrigger(player):
	self.canInteract = false;
	player.addToInventory(
		"Flower",
		randf_range(flowerQuantityRange[1], flowerQuantityRange[1])
	)
	player.setSavefileData(self.identifier+".canInteract", false)
	$Area2D/Sprite.texture = pickedFlowerSprite
	$Collider.shape = null
