extends Node2D

var time = 0
var endOfDayTime = 20   #in seconds
var timeLeft = endOfDayTime
var fadeToBlackTime = 4
var endOfDay = false
var dayNumber = 0;

onready var directionalLight = get_node(("../Garden/Lighting/DirectionalLight"))
onready var colorRect = get_node(("../Player/time_left_layer/FadeToBlackRect"))
onready var timeText = get_node("../Player/time_left_layer/TimeLeftLabel")
onready var player = get_node("../Player")

const START_ENERGY = 0.8
const MID_ENERGY = 6.725
const END_ENERGY = 0

var energyIncrease = ((MID_ENERGY - START_ENERGY) / (endOfDayTime / 2)) / 60
var energyDecrease = ((END_ENERGY - MID_ENERGY) / (endOfDayTime / 2)) / 60
var startToMiddleDay = true;
var	middleToEndDay = false;

var lightRotationAngle = (endOfDayTime / 400000.0)

var timePaused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	timeText.add_text("Time left in Day: " + str(timeLeft as int))
	colorRect.color.a = 0
	print("day number: " + str(dayNumber))
	directionalLight.rotation_degrees.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	
	timeText.clear()
	timeLeft = endOfDayTime - time
	timeText.add_text("Time left in Day: " + str(timeLeft as int)	)
	
	_update_Time(delta)
	_manage_Lighting_with_Time()
	_check_end_of_day(delta)

func _update_Time(delta):
	if !timePaused:
			if !endOfDay:
				time += delta
				timeLeft = endOfDayTime - time
			
func _manage_Lighting_with_Time():		
	if directionalLight.light_energy > MID_ENERGY:
		startToMiddleDay = false;
		middleToEndDay = true
		
	if(!timePaused):
		if startToMiddleDay:
			directionalLight.light_energy += energyIncrease
				
		if middleToEndDay:					
			directionalLight.light_energy += energyDecrease
			
		directionalLight.rotate_x(-lightRotationAngle)
		
func _check_end_of_day(delta):
	if !endOfDay:
		if time > endOfDayTime:
			endOfDay = true
			
	if endOfDay:
		fadeToBlackTime -= delta
		if fadeToBlackTime > 0:			
			colorRect.color.a += 0.005
		else:
			get_tree().call_group("flower_brains", "_decrease_health")
			_reset_day()
		
func _reset_day():
	player.global_translation = Vector3(17,1.804,2)
	colorRect.color.a = 0
	fadeToBlackTime = 5 
	dayNumber+=1
	time = 0
	endOfDay = false
	startToMiddleDay = true;
	middleToEndDay = false;
	directionalLight.light_energy = 0
	directionalLight.rotation_degrees.x = -1
	print("day number: " + str(dayNumber))
	
func _pause_time_dependencies():
	timePaused = true
	
func _unpause_time_dependencies():
	timePaused = false
	
func getRemainingTimeLeft():
	return endOfDayTime - time
