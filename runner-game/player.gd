extends CharacterBody2D


@export var turning_speed: int
# Jump export variables
@export var jump_force: float
@export var gravity: float
@export var jump_scale_amp: float

# References
@onready var animation_player: AnimationPlayer = $AnimationPlayer

enum States {running, jumping}

var state: States = States.running: set = set_state

# Variables
var turning_angle := deg_to_rad(25)
var height := 0.0
var height_velocity := 0.0
# State variables
var just_jumped := false


func set_state(new_state):
	if new_state == States.jumping:
		height_velocity = jump_force
	state = new_state

func _physics_process(delta: float) -> void:
	
	# Movement
	var direction := Input.get_axis("left", "right")
	velocity.x = lerp(velocity.x, direction * turning_speed, 0.08)
	rotation = deg_to_rad(velocity.x) * 0.05
	move_and_slide()
	
	if Input.is_action_pressed("jump") and state == States.running and !just_jumped:
		set_state(States.jumping)
		just_jumped = true
	if Input.is_action_just_released("jump"):
		just_jumped = false
	#region jumping
	if state == States.jumping:
		print(height_velocity)
		# JUMP
		height += height_velocity
		# Alter gravity if height velocity is under zero
		if height_velocity < 0:
			height_velocity -= gravity * 1.8
		else:
			height_velocity -= gravity
		if !Input.is_action_pressed("jump") and height_velocity > 0 and height > 8:
			height_velocity = 0
		scale = Vector2(height * jump_scale_amp + 1.0, height * jump_scale_amp + 1.0)
		
		if height < 0:
			height = 0
			scale = Vector2.ONE
			set_state(States.running)
	#endregion

func jump():
	pass
