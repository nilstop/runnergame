extends CharacterBody2D

@export var turning_speed: int
@export var jump_duration: float
# References
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum States {running, jumping}

var state: States = States.running: set = set_state

var turning_angle := deg_to_rad(25)

func set_state(new_state):
	state = new_state

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("left", "right")
	velocity.x = lerp(velocity.x, direction * turning_speed, 0.08)
	rotation = deg_to_rad(velocity.x) * 0.05
	move_and_slide()
	if Input.is_action_just_pressed("jump"):
		jump()

func jump():
	state = States.jumping
	animation_player.speed_scale = jump_duration
	animation_player.play("jumping")
