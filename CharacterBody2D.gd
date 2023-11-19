extends CharacterBody2D
@export var animationplayer:AnimatedSprite2D

@export var outlineShader: ShaderMaterial

const SPEED = 150.0
const JUMP_VELOCITY = -400.0


var interactablesInRange = []
var inventory = {}
var closestInteractable = null

var potentialPatrons = ["Fey", "Fiend", "Eldritch", "Coven"]

# Get the gravity from the project settings to be synced with RigidBody nodes.

func _ready():
	var patron = potentialPatrons[randi() % len(potentialPatrons)]
	print(patron)
	var outlineColor = null
	match patron:
		"Fey":
			outlineColor = Color(0.5,1.0,0.7,1.0)
		"Fiend":
			outlineColor = Color(0.9,0.5,0.6,1.0)
		"Eldritch":
			outlineColor = Color(0.5, 0.7, 1.0, 1.0)
		"Coven":
			outlineColor = Color(0.6,0.4,0.8,1.0)
		_:
			outlineColor = Color(1.0,1.0,1.0,1.0)
	outlineShader.set_shader_parameter("color", outlineColor)

	inventory = SaveFile.safeGet("Player.Inventory", [])
	print(inventory)
	SaveFile.setOrPut("Player.Patron", patron)


func _physics_process(_delta):
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var inputX = Input.get_axis("character_left", "character_right",)
	var inputY = Input.get_axis ("character_up" , "character_down")
	var input_direction = Vector2(inputX, inputY)
	velocity = input_direction.normalized() * SPEED	
		
	if inputY == -1:			
		animationplayer.play("up" ,1,4)
	elif inputY == 1:
		animationplayer.play("down",1,4)
	elif inputX == 1:
		animationplayer.play("right",1,4)
	elif inputX == -1:
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
