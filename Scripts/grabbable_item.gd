extends Area3D
class_name GrabbableItem

@export var item_id : String
@export var size : float = 0.5
@export var display_count : int = 1

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var sprite: Sprite3D = $Sprite

var item : Item

func _ready() -> void:
	collision_shape.shape.radius = size
	item = Item.new(item_id)
	sprite.texture = item.world_texture
	sprite.scale = Vector3.ONE * item.world_scale
	#print(item.display_name)
	
