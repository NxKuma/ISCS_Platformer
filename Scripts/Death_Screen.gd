extends CanvasLayer

@onready var player = $"../Player"

func _on_button_pressed():
	self.visible = false
	player.get_child(0).visible = true
	player.velocity = Vector2.ZERO
	player.get_child(1).disabled = false
	player.position = Vector2(-137,376)
