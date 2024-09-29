extends CharacterBody2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_left: int = 2
var direction: int = 1
var speed_limit: int = 200
#-----------------------------------------------------------------------------------------------
@onready var debug: CanvasLayer = $"../DebugLayer"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var death_screen = $"../DeathScreen"
@onready var gpu_particles_2d = $GPUParticles2D
#-----------------------------------------------------------------------------------------------
@export var walk_speed: int = 50
@export var run_speed: int = 200
@export var jump_velocity: float = -10.0
#-----------------------------------------------------------------------------------------------
@export_range(0,1) var jump_deccelerate: float = 0.1
@export_range(0,1) var deccelerate: float = 0.1
@export_range(0,1) var accelerate: float = 0.1

func _physics_process(delta):
	if !sprite.visible:
		return
		
	animation()
#-----------------------------------------------------------------------------------------------
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name.contains("Mushroom"):
			velocity.y = jump_velocity * 1.5
			jump_left = 1
		elif collision.get_collider().name.contains("Water"):
			collision_shape_2d.disabled = true
			gpu_particles_2d.emitting = true
			sprite.visible = false
			death_screen.visible = true
#-----------------------------------------------------------------------------------------------
	# Add the gravity.
	if not is_on_floor():
		if velocity.y <= 0:
			velocity.y += gravity * delta
		else:
			velocity.y += gravity * delta * 0.7
	else:
		jump_left = 2
#-----------------------------------------------------------------------------------------------
	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = jump_velocity
		jump_left -= 1
	elif Input.is_action_just_pressed("Space") and jump_left > 0:
		velocity.y = jump_velocity
		jump_left -= 1
	
	if Input.is_action_just_released("Space") and velocity.y < 0:
		velocity.y *= jump_deccelerate
#-----------------------------------------------------------------------------------------------
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("Left", "Right")
#-----------------------------------------------------------------------------------------------
	#Preserved Momentum
	if Input.is_action_pressed("Left"):
		if velocity.x > -speed_limit:
			velocity.x += direction * walk_speed *accelerate
		else:
			velocity.x = -speed_limit
	elif Input.is_action_pressed("Right"):
		if velocity.x < speed_limit:
			velocity.x += direction * walk_speed *accelerate
		else:
			velocity.x = speed_limit
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, walk_speed*deccelerate)
	move_and_slide()
#-----------------------------------------------------------------------------------------------
func _input(event: InputEvent):
	if event.is_action_pressed("Down") and is_on_floor_only():
		position.y += 1
#-----------------------------------------------------------------------------------------------
func animation():
	if direction == 1:
		sprite.set_flip_h(0)
	elif direction == -1:
		sprite.set_flip_h(1)
	
	if not is_on_floor():
		if velocity.y < 0:
			sprite.play("Jump")
		elif velocity.y > 0:
			sprite.play("Fall")
	elif is_on_floor():
		if velocity.x == 0:
			sprite.play("Idle")
		elif (direction == -1 and velocity.x > 0) or (direction == 1 and velocity.x < 0):
			sprite.play("Stop")
			if direction == -1:
				sprite.set_flip_h(0)
			else:
				sprite.set_flip_h(1)
		elif (Input.is_action_just_released("Left") or Input.is_action_just_released("Right")) and (velocity.x == speed_limit or velocity.x == -speed_limit):
			sprite.play("Stop")
		elif velocity.x != 0 and ((velocity.x < speed_limit and direction == 1) or (velocity.x > -speed_limit and direction == -1)):
			sprite.play("Walk")
		elif (velocity.x == speed_limit and direction == 1) or (velocity.x == -speed_limit and direction == -1):
			sprite.play("Run")
