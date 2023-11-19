extends CharacterBody2D
@export var animationplayer:AnimatedSprite2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0



# Get the gravity from the project settings to be synced with RigidBody nodes.



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
		animationplayer.play("left" , 1 , 4)
	elif velocity == Vector2(0,0):
		animationplayer.stop()
	
	
		
	#velocity =  velocity.normalized() * min(velocity.length(), SPEED)

	move_and_slide()
