extends Node2D

var time = 0
var endOfDayTime = 120 #in seconds
var endOfDay = false

onready var directionalLight = get_node(("../Lighting/DirectionalLight"))
const START_ENERGY = 0.8
const MID_ENERGY = 6.725
const END_ENERGY = 0

var energyIncrease = ((MID_ENERGY - START_ENERGY) / (endOfDayTime / 2)) / 60
var energyDecrease = ((END_ENERGY - MID_ENERGY) / (endOfDayTime / 2)) / 60
var startToMiddleDay = true;
var	middleToEndDay = false;

var lightRotationAngle = (endOfDayTime / 400000.0)

var pausedInDialogue = false

# Called when the node enters the scene tree for the first time.
func _ready():
	directionalLight.light_energy = 0
	directionalLight.rotation_degrees.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	
	if Input.is_action_just_pressed("jump"):
		pausedInDialogue = !pausedInDialogue
	
	if !pausedInDialogue:
		if !endOfDay:
			time += delta
	
	_manage_Lighting_with_Time()
	
	if !endOfDay:
		#print(time)
		if time > endOfDayTime:
			endOfDay = true
			#flowerBrain.currentFlowerHealth -= flowerHealthDecrement
			
	if endOfDay:
		get_tree().call_group("flower_brains", "_decrease_health")
		_reset_day()
#	pass

func _manage_Lighting_with_Time():		
	if directionalLight.light_energy > MID_ENERGY:
		startToMiddleDay = false;
		middleToEndDay = true
		
	if(!pausedInDialogue):
		if startToMiddleDay:
			directionalLight.light_energy += energyIncrease
				
		if middleToEndDay:					
			directionalLight.light_energy += energyDecrease
			
		directionalLight.rotate_x(-lightRotationAngle)
		
func _reset_day():
	time = 0
	endOfDay = false
	startToMiddleDay = true;
	middleToEndDay = false;
	directionalLight.light_energy = 0
	directionalLight.rotation_degrees.x = -1
	
func _pause_time_dependencies():
	pausedInDialogue = true
	
func _unpause_time_dependencies():
	pausedInDialogue = false
