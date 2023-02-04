extends Spatial


# signals
signal _on_food_received

#variables
var position : Vector3 = Vector3(1, 1, 1)
onready var flower := get_node("FlowerSprite")
export var character_name: String = ""
export var texture: Texture = null
onready var text_box:= get_node("Textbox")
var in_range_of_player: bool = false

onready var brain := get_node("FlowerBrain")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_flower(texture)
	text_box.hide()
	brain.character_name = character_name
	

func set_up_flower(png_name):
	flower.set_texture(png_name)

func _on_Area_body_entered(_body):
	text_box.show()
	in_range_of_player = true

func _on_Area_body_exited(_body):
	text_box.hide()
	in_range_of_player = false
	
	
func _input(_delta):
	if(in_range_of_player):
		if(Input.is_action_pressed("feed")):
			emit_signal("_on_food_received")
			
		if(Input.is_action_pressed("talk")):
			brain.talked_to()

