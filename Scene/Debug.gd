extends CanvasLayer
var debug_string: String
var input_string: String
@onready var player = $"../Player"
@onready var label = $Control/MarginContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _input(event):
	input_string = event.as_text()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	debug_string = "Velocity X: " + str(snappedf(player.velocity.x,0.01)) + "\nVelocity Y: " + str(snappedf(player.velocity.y,0.01)) +  "\nAcceleration: " + str(player.accelerate) + "\nGravity: " + str(player.gravity) + "\nDirection: " + str(player.direction) + "\nInput: " + input_string
	label.set_text(debug_string)
