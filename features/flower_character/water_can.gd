extends Spatial



# water can/ fertiliser
onready var equipable_object := get_node("CanSprite")

# textures
onready var fertilizer_texture: Texture = load("res://assets/images/fertaliser.png")
onready var can_texture: Texture = load("res://assets/images/watering_can.png")
var empty_texture: Texture = null


onready var compost_label:= get_node("../../compost_bin/lablel")


# icons
onready var no_water_drop_icon:= get_node("../no_water_Layer")
onready var water_drop_icon:= get_node("../water")
onready var no_fertilizer_icon:= get_node("../no_fertilizer/NoFertilizerIcon")
onready var fertilizer_icon:= get_node("../fetrilizer")


var well_in_proximity: bool = false;
var water_in_can: bool = false
var water_equiped: bool = false

signal water_can_equiped
signal water_can_unequiped
signal water_can_emptied
signal water_can_filled

# fertilizer

var compost_bin_in_proximity: bool = false
var fertilizer_full: bool = false
var fertilizer_equiped: bool = false


signal fertilizer_equiped
signal fertilizer_unequiped
signal fertilizer_full
signal fertilizer_empty



func _ready():
	equipable_object.set_texture(empty_texture)
	compost_label.hide()
	water_drop_icon.hide()
	fertilizer_icon.hide()
	
	
func _input(_event):
	if(well_in_proximity):
		if(Input.is_action_pressed("feed") && water_equiped):
			print("You got water from the well")
			emit_signal("water_can_filled")
			water_drop_icon.show()
			no_water_drop_icon.hide()
			water_in_can = true

	if(compost_bin_in_proximity):
		if(Input.is_action_pressed("feed") && fertilizer_equiped):
			print("You got compost from bin")
			emit_signal("fertilizer_full")
			fertilizer_full = true
			no_fertilizer_icon.hide()
			fertilizer_icon.show()
			
	if(Input.is_action_pressed("equip_water_can")):
		water_equiped = true
		fertilizer_equiped = false
		emit_signal("water_can_equiped")
		equipable_object.set_texture(can_texture)
			
	else: if (Input.is_action_pressed("equip_water_can") && water_equiped):
		water_equiped = false
		emit_signal("water_can_unequiped")
		equipable_object.set_texture(empty_texture)
		print("You unequiped the water can")
	
	if(Input.is_action_pressed("equip_fertilizer")&&!fertilizer_equiped):
		emit_signal("fertilizer_equiped")
		equipable_object.set_texture(fertilizer_texture)
		print("You equiped the fertilizer")
		fertilizer_equiped = true
		water_equiped = false
	else: if(Input.is_action_pressed("equip_fertilizer") && fertilizer_equiped):
		emit_signal("fertilizer_unequiped")
		equipable_object.set_texture(empty_texture)
		print("You unequiped the fertilizer")
		fertilizer_equiped = false
	
	
func _water_received():
	print("water can now knows its empty")
	emit_signal("water_can_emptied") 
	water_in_can = false
	no_water_drop_icon.show()
	water_drop_icon.hide()

func _on_Area_body_entered_compost(compost_bin):
	compost_label.show()
	compost_bin_in_proximity = true


func _on_Area_body_exited_compost(compost_bin):
	compost_label.hide()
	compost_bin_in_proximity = false


func _fertilizer_emptied():
	fertilizer_icon.hide()
	no_fertilizer_icon.show()
	fertilizer_full = false


func _on_Area_body_entered_well(body):
	well_in_proximity = true
	


func _on_Area_body_exited_well(body):
	well_in_proximity = false
