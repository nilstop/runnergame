extends Node2D

@export var hole: PackedScene

func _on_timer_timeout() -> void:
	inst(hole)

func inst(scene):
	var instance = scene.instantiate()
	instance.global_position = Vector2(randi_range(200, get_viewport_rect().size.x - 200), -200)
	add_child(instance)
