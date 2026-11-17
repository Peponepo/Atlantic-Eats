extends CharacterBody3D

@export var turn_speed: float = 10.0

var target_rotation: float = 0.0

func _input(event):
	#if D is pressed, turn right
	if event.is_action_pressed("turn_right"):
		target_rotation -= 90.0

	#if S is pressed, turn around
	elif event.is_action_pressed("turn_around"):
		target_rotation += 180.0

	#if A is pressed, turn left
	elif event.is_action_pressed("turn_left"):
		target_rotation += 90.0


func _process(delta):
	rotation.y = lerp_angle(
		rotation.y,
		deg_to_rad(target_rotation),
		1.0 - exp(-turn_speed * delta)
	)
