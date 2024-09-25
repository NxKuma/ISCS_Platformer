extends CharacterBody2D


@export var speed = 8
@export var jump_velocity = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
@export var gravity = 9.18


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Space") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x += direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
