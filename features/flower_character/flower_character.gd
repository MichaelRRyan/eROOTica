extends Spatial


# signals
signal _on_food_received
signal _on_water_received
signal _in_dialogue


signal _fertilizer_emptied

#variables
onready var brain := get_node("FlowerBrain")
onready var flower := get_node("FlowerSprite")
onready var text_box:= get_node("Textbox")



export var character_name: String = ""
export var texture: Texture = null


var in_range_of_player: bool = false
var can_be_watered: bool = false
var water_equiped:bool = false
var fertilzer_equiped:bool = false
var fertilzer_full:bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_up_flower(texture)
	text_box.hide()
	brain.setup(character_name)
	

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
		if(in_range_of_player && can_be_watered && water_equiped ):
			emit_signal("_on_water_received")
			emit_signal("_water_emptied")
			print("You watered the flower")
			can_be_watered = false

			
		if (in_range_of_player && fertilzer_full && fertilzer_equiped ):
			emit_signal("_on_food_received")
			emit_signal("_fertilizer_emptied")
			print("You fertilizer the flower")
			fertilzer_full = false
	
	if event.is_action_pressed("talk") and in_range_of_player:
		brain.talked_to()
		emit_signal("_in_dialogue")


func _water_can_emptied():
	can_be_watered = false


func _water_can_filled():
	can_be_watered = true


func _water_can_equiped():
	water_equiped = true

func _water_can_unequiped():
	water_equiped = false


func _fertilizer_equiped():
	fertilzer_equiped = true


func _fertilizer_unequiped():
	fertilzer_equiped = false


func _fertilizer_full():
	fertilzer_full = true
