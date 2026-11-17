
extends TextureRect

@export var cursor_distance: float = 100.0
@export var cursor_sensitivity: float = 0.5
@export var smoothness: float = 8.0

var target_offset := Vector2.ZERO
var screen_center := Vector2.ZERO

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	#get screen center
	screen_center = get_viewport_rect().size / 2
	position = screen_center - size / 2


func _input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:

			target_offset += event.relative * cursor_sensitivity

			target_offset = target_offset.limit_length(cursor_distance)


func _process(delta):
	var weight = 1.0 - exp(-smoothness * delta)

	var current_position = position + size / 2
	var target_position = screen_center + target_offset

	current_position = current_position.lerp(
		target_position,
		weight
	)

	position = current_position - size / 2
