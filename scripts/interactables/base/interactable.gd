extends StaticBody2D

class_name Interactable

@export var defaultSprite: Texture2D
@export var collisionShape: Shape2D
@export var identifier: String

# set to false when player cannot interact with this entity
@onready var canInteract = true

# assign default sprite, collision shape, and trigger everything tied to the children class's onReady function
func _ready():
	$Area2D/Sprite.texture = defaultSprite
	$Collider.shape = collisionShape
	onReady()
	
# run this when player enters TriggerArea and is the closest to this specific interactable
func onTriggerEnter(player):
	if (canInteract):
		player.addInteractables(self)
		
#run this if player exits the TriggerArea or another interactable is the closest to it
func onTriggerExit(player):
	player.removeInteractables(self)
		
# responsible for drawing a bright outline around the sprite
func conditionallySetOutlineVisibility(value):
	if($Area2D/Sprite.texture != null):
		$Area2D/Sprite.use_parent_material = !value	

# Called when player chooses to interact with this entity, by pressing a key
func onInteraction(player):
	if (canInteract):
		self.onInteractionTrigger(player)

# Called when entity can actually interact with player
func onInteractionTrigger(player):
	pass
	
# use this function in children classes if object needs to be set up in some way
# for example, as a result of progression achieved inside a save file
func onReady():
	pass
