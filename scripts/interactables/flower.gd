extends Interactable

class_name Flower

@export var pickedFlowerSprite: Texture2D


var flowerQuantityRange = [0.75, 1.4]	

# Flower gets picked
func onInteractionTrigger(player):
	self.canInteract = false;
	$Area2D/Sprite.texture = pickedFlowerSprite
	player.addToInventory(
		"Flower",
		randf_range(flowerQuantityRange[0], flowerQuantityRange[1])
	)
	$Collider.shape = null
