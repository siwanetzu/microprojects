extends Node2D

@export var spawn_count : int = 200
var star_scene = preload("res://Loops/Assets/Star.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in spawn_count:
		var star = Sprite2D.new()
		star.texture = star_scene
		add_child(star)
		
		star.position.x = randi_range(-280, 280)
		star.position.y = randi_range(-150, 150)
		
		var star_size = randf_range(0.5, 1.0)
		star.scale.x = star_size
		star.scale.y = star_size