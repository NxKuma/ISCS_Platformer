extends Area2D

@onready var frog_sfx: AudioStreamPlayer2D = $FrogSFX

func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		frog_sfx.play()
		print(frog_sfx.is_playing())
