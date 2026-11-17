extends Node3D
@export var turn_speed: float = 10.0

@export_category("Camera Lean")
@export var max_lean: Vector2 = Vector2(4, 4)
@export var lean_deadzone: Vector2 = Vector2(1, 1)
@export var lean_speed : Vector2 = Vector2.ONE * 0.005
#@export var mouse_sensitivity: float = 0.015

@export_category("Cursor")
@export var snap_cursor: float = 5.0
@export var cursor_default_tex : Texture2D
@export var cursor_default_scale : float = 1.0
@export var cursor_turn_dist : float = 100.0

var target_lean := Vector2.ZERO

@onready var cursor: Node2D = %CursorHolder
@onready var camera: Camera3D = %Camera
@onready var cursor_raycast: RayCast3D = %CursorRaycast

const MAX_GRAB_DIST = 40.0

var target_rotation: float = 0.0
var hovered_item : GrabbableItem
var held_item : Item
var view_animating : bool = false
var tween : Tween

func rotate_to(angle : float):
	angle = deg_to_rad(angle)
	target_rotation += angle
	angle = target_rotation
	view_animating = true
	if tween : tween.stop()
	tween = create_tween()
	tween.tween_property(self, "rotation:y",  lerp_angle(rotation.y, angle, 0.9), 0.15).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "rotation:y", lerp_angle(rotation.y, angle, 1.0), 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	await  tween.finished
	view_animating = false
	
func _input(event):
	#if D is pressed, turn right
	if event.is_action_pressed("turn_right"):
		rotate_to(-90)

	#if S is pressed, turn around
	elif event.is_action_pressed("turn_around"):
		rotate_to(180)

	#if A is pressed, turn left
	elif event.is_action_pressed("turn_left"):
		rotate_to(90)
	
	elif event.is_action_pressed("pick_up") and hovered_item and not held_item:
		
		held_item = hovered_item.item
		print("held ", hovered_item.item.display_name)
	
	elif event.is_action_released("pick_up"):
		held_item = null
		print("unheld")


func _process(delta):
	# calc camera lean
	var lean_dir : Vector2 = (-cursor.target_offset) * lean_speed
	target_lean.x = clamp(lean_dir.x - sign(lean_dir.x) * lean_deadzone.x, -max_lean.x, max_lean.x) if abs(lean_dir.x) > lean_deadzone.x else 0.0
	target_lean.y = clamp(lean_dir.y - sign(lean_dir.y) * lean_deadzone.y, -max_lean.y, max_lean.y) if abs(lean_dir.y) > lean_deadzone.y else 0.0
	
	camera.rotation.x = lerp_angle(
		camera.rotation.x,
		deg_to_rad(target_lean.y),
		snap_cursor * delta
	)

	camera.rotation.z = lerp_angle(
		camera.rotation.z,
		deg_to_rad(target_lean.x),
		snap_cursor * delta
	)
	
	var edge_dist : float = Util.window_center.x - abs(cursor.target_offset.x)
	if edge_dist < cursor_turn_dist: 
		rotate_to(90 * sign(-cursor.target_offset.x))
		cursor.target_offset.x *= -1
		cursor.target_offset.x += sign(-cursor.target_offset.x) * cursor_turn_dist
	
	
	# test for grabbable items
	var cursor_normal : Vector3 = camera.project_ray_normal(cursor.position); # get where the plr is looking
	cursor_normal = cursor_normal.rotated(Vector3.UP, -camera.global_rotation.y) # correct for parent rotation
	cursor_raycast.target_position = cursor_normal * MAX_GRAB_DIST
	cursor_raycast.force_raycast_update()
	hovered_item = null
	if cursor_raycast.is_colliding():
		var area : Area3D = cursor_raycast.get_collider()
		if area is GrabbableItem:
			hovered_item = area
	
	var cursor_img : TextureRect = cursor.cursor_img
	if held_item:
		cursor_img.texture = held_item.cursor_texture
		cursor_img.scale = Vector2.ONE * held_item.cursor_scale
	
	else: 
		cursor_img.texture = cursor_default_tex
		cursor_img.scale = Vector2.ONE * cursor_default_scale
	
	
	#rotation.y = lerp_angle(
		#rotation.y,
		#deg_to_rad(target_rotation),
		#1.0 - exp(-turn_speed * delta)
	#)
	
	
