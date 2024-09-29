extends Control
#
##@onready var forest_back: Sprite2D = $"CanvasLayer/ForestBack"
##@onready var forest_front: Sprite2D = $"CanvasLayer/ForestFront"
##@onready var player: CharacterBody2D = $"../Player"
#
#var default_size: Vector2 = Vector2(576,452)
#var forest_back_scale: float = 0.2
#var forest_front_scale: float = 0.4
#
## Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.
#
##
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#var playerx = player.position.x
	#var playery = player.position.y
	#forest_back.set_region_rect(Rect2(Vector2(playerx * forest_back_scale, playery*forest_back_scale ), Vector2(576,452)))
	#forest_front.set_region_rect(Rect2(Vector2(playerx * forest_front_scale, playery*forest_back_scale), Vector2(576,452)))
