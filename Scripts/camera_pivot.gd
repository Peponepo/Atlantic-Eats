extends Node3D

#func _input(event):
	#if event is InputEventMouseMotion:
		#if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			# Horizontal mouse movement = camera roll
			#target_rotation.z = clamp(
				#-event.relative.x * mouse_sensitivity,
				#-deg_to_rad(max_lean),
				#deg_to_rad(max_lean)
			#)
#
			## Vertical mouse movement = camera pitch
			#target_rotation.x = clamp(
				#-event.relative.y * mouse_sensitivity,
				#-deg_to_rad(max_lean),
				#deg_to_rad(max_lean)
			#)


#func _process(delta):
	#pass
