extends Area2D

@onready var frog_sfx: AudioStreamPlayer2D = $"../FrogSFX"

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		frog_sfx.play()
