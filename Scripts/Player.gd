extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

@export var walk_speed: int = 350
@export var run_speed: int = 500
@export var jump_velocity: float = -600.0
@export_range(0,1) var jump_deccelerate: float = 0.5
@export_range(0,1) var deccelerate: float = 0.1
@export_range(0,1) var accelerate: float = 0.1

var jump_left: int = 2

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		jump_left = 2

	# Handle jump.
	if Input.is_action_just_pressed("Space") and (is_on_floor() or is_on_wall()):
		velocity.y = jump_velocity
		jump_left -= 1
	elif Input.is_action_just_pressed("Space") and jump_left > 0:
		velocity.y = jump_velocity
		jump_left -= 1
	
	if Input.is_action_just_released("Space") and velocity.y < 0:
		velocity.y *= jump_deccelerate
	
	#Handle Running
	var speed:int
	var speed_limit:int
	if Input.is_action_pressed("Run") and is_on_floor():
		speed = run_speed
		speed_limit = 600
	else:
		speed = walk_speed
		speed_limit = 300

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	#Non-Preserved Momentum
	#if direction:
		#velocity.x = move_toward(velocity.x, direction * speed, speed * accelerate)
		##velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed*deccelerate)
#-----------------------------------------------------------------------------------------------
	#Preserved Momentum
	
	if Input.is_action_pressed("Left"):
		if velocity.x > -speed_limit:
			velocity.x += direction * speed
		else:
			velocity.x = -speed_limit
	elif Input.is_action_pressed("Right"):
		if velocity.x < speed_limit:
			velocity.x += direction * speed
		else:
			velocity.x = speed_limit
	
	
	#if direction:
		##velocity.x = move_toward(velocity.x, direction * speed, speed * accelerate)
		#if velocity.x <= speed_limit and velocity.x >= -speed_limit:
			#velocity.x += direction * speed 
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, speed*deccelerate)
	print(velocity.x)
	move_and_slide()
