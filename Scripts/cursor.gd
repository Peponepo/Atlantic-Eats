extends Node2D

#@export var cursor_distance: float = 100.0
@export var cursor_sensitivity: float = 0.5
@export var smoothness: float = 8.0
@export var player: Node3D

@onready var cursor_img: TextureRect = %Cursor

var target_offset := Vector2.ZERO

func _ready():
	position = Util.window_center

func _input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			target_offset += event.relative * cursor_sensitivity
			target_offset = target_offset.clamp(-Util.window_center, Util.window_center)
			
			


func _process(delta):
	var target_position = Util.window_center + target_offset
	
	if player.view_animating:
		var weight = (smoothness * delta)
		position = lerp(position, target_position, weight)
		
	else:
		position = target_position
	
	#var current_position = position + size / 2
	
	
	#current_position = current_position.lerp(
		#target_position,
		#weight
	#)
#
	#position = current_position - size / 2
