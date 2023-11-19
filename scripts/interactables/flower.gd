extends Interactable

class_name Flower

@export var pickedFlowerSprite: Texture2D

#randomizes the amount of "flower" picked up
var flowerQuantityRange = [1.0, 1.0]	

# Flower gets picked
func onInteractionTrigger(player):
	self.canInteract = false;
	$Area2D/Sprite.texture = pickedFlowerSprite
	player.addToInventory(
		"Flower",
		randf_range(flowerQuantityRange[1], flowerQuantityRange[1])
	)
	$Collider.shape = null
