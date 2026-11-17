class_name Item

var item_id : String
var display_name : String

var world_texture : Texture2D
var world_scale : float

var cursor_texture : Texture2D
var cursor_scale : float

const ITEMS : Dictionary[String, Dictionary] = {
	"cigs" : {
		"display_name" : "Marlinboros",
		
		"world_texture" : preload("res://Art/2D/Item/Marlinboros.png"),
		"world_scale" : 1.0,
		
		"cursor_texture" : preload("res://Art/2D/Item/Marlinboros.png"),
		"cursor_scale" : 3.0
	},
	"energy" : {
		"display_name" : "Energy",
		
		"world_texture" : preload("res://Art/2D/Item/energy.png"),
		"world_scale" : 1.0,
		
		"cursor_texture" : preload("res://Art/2D/Item/energy.png"),
		"cursor_scale" : 3.0
	},
	"shake" : {
		"display_name" : "Shake",
		
		"world_texture" : preload("res://Art/2D/Item/shake.png"),
		"world_scale" : 1.0,
		
		"cursor_texture" : preload("res://Art/2D/Item/shake.png"),
		"cursor_scale" : 3.0
	}
	
}

func _init(_item_id : String) -> void:
	for variable : String in ITEMS["cigs"].keys():
		set(variable, ITEMS[_item_id][variable])
	
