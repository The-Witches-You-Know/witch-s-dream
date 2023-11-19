extends CharacterBody2D
@export var animationplayer:AnimatedSprite2D

@export var outlineShader: ShaderMaterial

const SPEED = 150.0
const JUMP_VELOCITY = -400.0


var interactablesInRange = []
var inventory = {}
var closestInteractable = null


# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	outlineShader.set_shader_parameter("color", Color(randf(), randf(), randf(), 1.0))
	if SaveFile.saveData.has("Player.Inventory"):
		inventory = SaveFile.saveData["Player.Inventory"]
		print(inventory)


func _physics_process(_delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("character_left", "character_right",)
	var directionupdown = Input.get_axis ("character_up" , "character_down")
	var input_direction = Input.get_vector("character_left", "character_right", "character_up", "character_down")
	velocity = input_direction * SPEED
	
	
		
	if directionupdown == -1:			
		animationplayer.play("up" ,1,4)
	elif directionupdown == 1:
		animationplayer.play("down",1,4)
	elif direction == 1:
		animationplayer.play("right",1,4)
	elif direction == -1:
		animationplayer.play("left",1,4)
	elif velocity == Vector2(0,0):
		animationplayer.stop()
	
	
		
	#velocity =  velocity.normalized() * min(velocity.length(), SPEED)
	move_and_slide()
	
	refreshClosestInteractable()
		
	
func _input(ev):
	if ev is InputEventMouseButton and ev.button_index == MOUSE_BUTTON_LEFT and ev.pressed:
		if (closestInteractable != null):
			closestInteractable.onInteraction(self)
	
func addInteractables(interactable):
	interactablesInRange.append(interactable)
	refreshClosestInteractable()
	
func removeInteractables(interactable):
	var candidateInteractables = interactablesInRange.filter(func(x): return x.position == interactable.position)
	if len(candidateInteractables) > 0:		
		interactablesInRange.erase(candidateInteractables[0])	
	refreshClosestInteractable()
	
	
func refreshClosestInteractable():	
	var detectedClosestInteractable = getClosestInteractable()
	if (detectedClosestInteractable != closestInteractable):
		if (closestInteractable != null):
			closestInteractable.conditionallySetOutlineVisibility(false)
		if (detectedClosestInteractable != null):
			detectedClosestInteractable.conditionallySetOutlineVisibility(true)
		closestInteractable = detectedClosestInteractable
	
func getClosestInteractable():
	var potentialClosestInteractable = null
	var closestDistance = 99999999
	for interactable in interactablesInRange:
		var distance = self.position.distance_to(interactable.position)
		if (closestDistance > distance):
			closestDistance = distance
			potentialClosestInteractable = interactable
	return potentialClosestInteractable
	
func addToInventory(itemName, amount):
	if itemName in inventory:
		inventory[itemName] += amount
	else:
		inventory[itemName] = amount
	SaveFile.setOrPut("Player.Inventory", inventory)


func _on_area_2d_area_entered(area):
	if (area.get_parent().has_method("onTriggerEnter")):
		area.get_parent().onTriggerEnter(self)


func _on_area_2d_area_exited(area):
	if (area.get_parent().has_method("onTriggerExit")):
		area.get_parent().onTriggerExit(self)
