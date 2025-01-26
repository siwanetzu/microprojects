extends Area3D

@export var clicks_to_pop : int = 3
var size_increase : float = 0.2
var score_to_give : int = 1

# Physics properties
var velocity = Vector3.ZERO
var gravity_force = Vector3(0, 1, 0)  # Downward gravity
var buoyancy = Vector3(0, -2, 0)  # Natural upward force
var max_height = 10.0  # Maximum height balloons can reach
var rise_force = 5.0   # Force applied when clicked
var wobble_strength = 0.1  # Random movement strength

func _physics_process(delta):
	# Apply gravity and buoyancy
	velocity += gravity_force * delta
	velocity += buoyancy * delta
	
	# Add some random movement for balloon-like effect
	velocity.x += (randf() - 0.5) * wobble_strength
	velocity.z += (randf() - 0.5) * wobble_strength
	
	# Update position
	position += velocity * delta
	
	# Clamp height to keep balloon in view
	position.y = clamp(position.y, 0, max_height)
	
	# Dampen velocity for more natural movement
	velocity *= 0.98

func _on_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		# Add upward force when clicked
		velocity += Vector3(0, rise_force, 0)
		
		scale += Vector3.ONE * size_increase
		clicks_to_pop -= 1
		
		if clicks_to_pop == 0:
			get_node("/root/Main").increase_score(score_to_give)
			queue_free()
