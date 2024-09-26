extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_left: int = 2

@onready var debug: CanvasLayer = $"../DebugLayer"

@export var walk_speed: int = 350
@export var run_speed: int = 500
@export var jump_velocity: float = -600.0

@export_range(1,2) var gravity_level: float = 1
@export_range(0,1) var jump_deccelerate: float = 0.5
@export_range(0,1) var deccelerate: float = 0.1
@export_range(0,1) var accelerate: float = 0.1

func _ready():
	gravity *= gravity_level

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
	if Input.is_action_pressed("Run"):
		speed = run_speed
		speed_limit = 600
	else:
		speed = walk_speed
		speed_limit = 480

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
			velocity.x += direction * speed *accelerate
	elif Input.is_action_pressed("Right"):
		if velocity.x < speed_limit:
			velocity.x += direction * speed *accelerate
	else:
		velocity.x = move_toward(velocity.x, 0, speed*deccelerate)
		
	move_and_slide()
	
#-----------------------------------------------------------------------------------------------
	#var label:RichTextLabel = debug.get_child(0).get_child(0).get_child(0)
	#label.set_text("Velocity X: " + str(snappedf(velocity.x,0.01)) + "\nDirection: " + str(direction))
	
func _input(event):
	var label:RichTextLabel = debug.get_child(0).get_child(0).get_child(0)
	var direction = Input.get_axis("Left", "Right")
	label.set_text("Velocity X: " + str(snappedf(velocity.x,0.01)) + "\nDirection: " + str(direction) + "\nInput: " + event.as_text())
