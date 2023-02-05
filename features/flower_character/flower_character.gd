extends Spatial


# signals
signal _on_food_received
signal _on_water_received
signal _in_dialogue


#variables
var position : Vector3 = Vector3(1, 1, 1)
onready var flower := get_node("FlowerSprite")
onready var text_box:= get_node("Textbox")



export var character_name: String = ""
export var texture: Texture = null


var in_range_of_player: bool = false
var can_be_watered: bool = false

onready var brain := get_node("FlowerBrain")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_flower(texture)
	text_box.hide()
	brain.set_name(character_name)
	

func set_up_flower(png_name):
	flower.set_texture(png_name)

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		text_box.show()
		in_range_of_player = true

func _on_Area_body_exited(body):
	if body.is_in_group("player"):
		text_box.hide()
		in_range_of_player = false
	
func water_can_equiped():
	print("flower now knows the can is equiped")
	can_be_watered = true
	

func _input(event):
	
	if(Input.is_action_pressed("feed")):
		if(in_range_of_player && can_be_watered):
			emit_signal("_on_water_received")
			print("You watered the flower")
			can_be_watered = false
	
	if event.is_action_pressed("talk") and in_range_of_player:
		brain.talked_to()
		emit_signal("_in_dialogue")


func _water_can_emptied():
	can_be_watered = false


func _water_can_filled():
	can_be_watered = true
