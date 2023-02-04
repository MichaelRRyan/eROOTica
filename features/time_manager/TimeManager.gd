extends Node2D


var time = 0
var endOfDayTime = 20 #in seconds
var endOfDay = false

var dayReset = false

onready var flowerBrain = get_node("../FlowerBrain")
var flowerHealthDecrement = 0.1

onready var directionalLight = get_node(("../Lighting/DirectionalLight"))
const START_ENERGY = 0.8
const MID_ENERGY = 6.725
const END_ENERGY = 0

var energyIncrease = ((MID_ENERGY - START_ENERGY) / (endOfDayTime / 2)) / 60
var energyDecrease = ((END_ENERGY - MID_ENERGY) / (endOfDayTime / 2)) / 60
var startToMiddleDay = true;
var	middleToEndDay = false;

var lightRotationAngle = (endOfDayTime / 10000.0)


	

# Called when the node enters the scene tree for the first time.
func _ready():
	directionalLight.light_energy = 0
	directionalLight.rotation_degrees.x = -1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if dayReset:
		dayReset = false
		endOfDay = false
		time = 0
		
	
	time += delta
	
	
	
	_manage_Lighting_with_Time()
	
	
	if !endOfDay:
		print(time)
		if time > endOfDayTime:
			endOfDay = true
			flowerBrain.currentFlowerHealth -= flowerHealthDecrement
#	pass

func _manage_Lighting_with_Time():		
	if directionalLight.light_energy > MID_ENERGY:
		startToMiddleDay = false;
		middleToEndDay = true
		
	if startToMiddleDay:
		directionalLight.light_energy += energyIncrease
			
	if middleToEndDay:					
		directionalLight.light_energy += energyDecrease
		
		#rotation
	directionalLight.rotate_x(-lightRotationAngle)
	
	pass
