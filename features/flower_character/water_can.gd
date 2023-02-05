extends Spatial



# water can
onready var well_can := get_node("CanSprite")
onready var can_texture: Texture = load("res://assets/images/watering_can.png")
onready var compost_label:= get_node("../../compost_bin/lablel")
onready var well_label:= get_node("../../well/label")

var empty_texture: Texture = null
var well_in_proximity: bool = false;
var water_in_can: bool = false
var water_equiped: bool = false

signal water_can_equiped
signal water_can_unequiped
signal water_can_emptied
signal water_can_filled

# fertilizer
onready var fertilizer_texture: Texture = load("res://assets/images/fertaliser.png")
var compost_bin_in_proximity: bool = false
var fertilizer_full: bool = false
var fertilizer_equiped: bool = false


signal fertilizer_equiped
signal fertilizer_unequiped
signal fertilizer_full
signal fertilizer_empty



func _ready():
	well_can.set_texture(empty_texture)
	well_label.hide()
	compost_label.hide()
	
func _on_Area_body_entered(body):
	print("can entered")
	well_in_proximity = true;
	well_label.show()
	
	
func _on_Area_body_exited(_body):
	print("can exited")
	well_in_proximity = false;
	well_label.hide()
	
	
func _input(delta):
	if(well_in_proximity):
		if(Input.is_action_pressed("feed") && water_equiped):
			print("You got water from the well")
			emit_signal("water_can_filled")
			water_in_can = true
			
			
			
	if(compost_bin_in_proximity):
		if(Input.is_action_pressed("feed") && fertilizer_equiped):
			print("You got compost from bin")
			emit_signal("fertilizer_full")
			fertilizer_full = true
			
			
	if(Input.is_action_pressed("equip_water_can")):
			water_equiped = true
			emit_signal("water_can_equiped")
			well_can.set_texture(can_texture)
			print("Yyou equiped the water can")
			
	else: if (Input.is_action_pressed("equip_water_can") && water_equiped):
		water_equiped = false
		emit_signal("water_can_unequiped")
		well_can.set_texture(empty_texture)
		print("You unequiped the water can")
	
	if(Input.is_action_pressed("equip_fertilizer")&&!fertilizer_equiped):
			emit_signal("fertilizer_equiped")
			well_can.set_texture(fertilizer_texture)
			print("You equiped the fertilizer")
			fertilizer_equiped = true
	else: if(Input.is_action_pressed("equip_fertilizer") && fertilizer_equiped):
			
			emit_signal("fertilizer_unequiped")
			well_can.set_texture(empty_texture)
			print("You unequiped the fertilizer")
			fertilizer_equiped = false
	
		
	


func _water_received():
	print("water can now knows its empty")
	emit_signal("water_can_emptied") 
	water_in_can = false





func _on_Area_body_entered_compost(compost_bin):
	compost_label.show()
	compost_bin_in_proximity = true


func _on_Area_body_exited_compost(compost_bin):
	compost_label.hide()
	compost_bin_in_proximity = false
