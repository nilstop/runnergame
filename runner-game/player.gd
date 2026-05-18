extends CharacterBody2D

@export var turning_speed: int

var turning_angle := deg_to_rad(25)

func _process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	velocity.x = direction * turning_speed
	rotation = lerp(rotation, direction * turning_angle, 0.2)
	move_and_slide()
