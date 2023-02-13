extends Spatial


# signals
signal _on_food_received
signal _on_water_received
signal _in_dialogue

signal _water_can_emptied_from_individual_flower
signal _fertilizer_emptied_from_individual_flower

#variables
onready var brain := get_node("FlowerBrain")
onready var flower := get_node("FlowerSprite")
onready var text_box:= get_node("Textbox")



export var character_name: String = ""
export var texture: Texture = null


var in_range_of_player: bool = false
var water_can_full: bool = false
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
	

	

func _input(event):
	
	if(Input.is_action_pressed("feed")):
		if(in_range_of_player && water_can_full && water_equiped ):
			emit_signal("_on_water_received")
			emit_signal("_water_can_emptied_from_individual_flower")
			print("You watered the flower")
			water_can_full = false

			
		if (in_range_of_player && fertilzer_full && fertilzer_equiped ):
			emit_signal("_on_food_received")
			emit_signal("_fertilizer_emptied_from_individual_flower")
			print("You fertilizer the flower")
			fertilzer_full = false
	
	if event.is_action_pressed("talk") and in_range_of_player:
		brain.talked_to()
		emit_signal("_in_dialogue")




# signal from other flowers on status of resources
func _water_can_filled_from_flowerbed():
	water_can_full = true
	print("indovidual flower knows water is full")

func _water_can_emptied_from_flowerbed():
	water_can_full = false
	print("indovidual flower knows water is empty")

func _fertilizer_is_full_from_flowerbed():
	fertilzer_full = true
	print("indovidual flower knows fetilizer is full")

func _fertilizer_is_empty_from_flowerbed():
	fertilzer_full = false
	print("indovidual flower knows fertilizer is empty")



# signal from other flowers on status of player equipment
func _fertilizer_equiped_from_flowerbed():
	print("indovidual flower knows fertilizer is equiped")
	fertilzer_equiped = true
	water_equiped = false

func _fertilizer_unequiped_from_flowerbed():
	print("indovidual flower knows fertilizer is unequiped")
	fertilzer_equiped = false
	
func _water_can_equiped_from_flowerbed():
	print("indovidual flower knows water is equiped")
	water_equiped = true
	fertilzer_equiped = false

func _water_can_unequiped_from_flowerbed():
	print("indovidual flower knows water is unequiped")
	water_equiped = false
