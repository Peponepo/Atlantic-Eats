
extends Node3D

@export_category("Camera Lean")
@export var max_lean: float = 4.0
@export var mouse_sensitivity: float = 0.015
@export var smoothness: float = 5.0

var target_rotation := Vector3.ZERO

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:

			# Horizontal mouse movement = camera roll
			target_rotation.z = clamp(
				-event.relative.x * mouse_sensitivity,
				-deg_to_rad(max_lean),
				deg_to_rad(max_lean)
			)

			# Vertical mouse movement = camera pitch
			target_rotation.x = clamp(
				-event.relative.y * mouse_sensitivity,
				-deg_to_rad(max_lean),
				deg_to_rad(max_lean)
			)


func _process(delta):
	var weight = 1.0 - exp(-smoothness * delta)

	rotation.x = lerp_angle(
		rotation.x,
		target_rotation.x,
		weight
	)

	rotation.z = lerp_angle(
		rotation.z,
		target_rotation.z,
		weight
	)
