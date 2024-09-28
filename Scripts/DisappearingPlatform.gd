extends StaticBody2D

@onready var timer: Timer = $Timer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player" and self.get_modulate() != Color(1,1,1,0):
		timer.start()
	
func _on_timer_timeout() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.4) #change the disappear speed by changing the 0.5
	collision_shape_2d.disabled = true
	await get_tree().create_timer(3.0).timeout
	tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 1, 0.4)
	collision_shape_2d.disabled = false
