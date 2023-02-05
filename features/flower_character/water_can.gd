extends Spatial



# water can
onready var well_can := get_node("CanSprite")
onready var can_texture: Texture = load("res://assets/images/watering_can.png")
var empty_texture: Texture = null
var well_in_proximity: bool = false;
var water_in_can: bool = false
var water_equiped: bool = false

signal water_can_equiped
signal water_can_emptied
signal water_can_filled

# fertilizer
onready var fertilizer_texture: Texture = load("res://assets/images/fertaliser.png")
var compost_bin_in_proximity: bool = false;
var compost_full: bool = false
var compost_equiped: bool = false



func _ready():
	well_can.set_texture(empty_texture)
	
func _on_Area_body_entered(body):
	print("can entered")
	well_in_proximity = true;
	
	
func _on_Area_body_exited(_body):
	print("can exited")
	well_in_proximity = false;
	
	
func _input(delta):
	if(well_in_proximity):
		if(Input.is_action_pressed("feed") && water_equiped):
			print("You got water from the well")
			emit_signal("water_can_filled")
			water_in_can = true
			
	if(Input.is_action_pressed("equip_water_can") && !water_equiped):
			water_equiped = true
			emit_signal("water_can_equiped")
			well_can.set_texture(can_texture)
			print("Yyou equiped the water can")
			
	else: if (Input.is_action_pressed("equip_water_can") && water_equiped):
		water_equiped = false
		#emit_signal("water_can_equiped")
		well_can.set_texture(empty_texture)
		print("You unequiped the water can")
		
	


func _water_received():
	print("water can now knows its empty")
	emit_signal("water_can_emptied") 
	water_in_can = false





