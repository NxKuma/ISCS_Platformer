extends Area2D

@onready var teleport_sfx: AudioStreamPlayer2D = $TeleportSFX

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		teleport_sfx.play()
		body.set_position($DestinationPointer.global_position)
