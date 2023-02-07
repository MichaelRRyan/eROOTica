extends Node2D

var time = 0
var endOfDayTime = 5   #in seconds
var timeLeft = endOfDayTime
var fadeToBlackTime = 4
var fadeToNormalTime = 4
var endOfDay = false
var dayNumber = 0;

enum TIME_STATES{
	GameTime,
	FadeToBlackTime,
	FadeToGameTime
}

var currentTimeStates

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
	currentTimeStates = TIME_STATES.GameTime
	timeText.add_text("Time left in Day: " + str(timeLeft as int))
	colorRect.color.a = 0
	print("day number: " + str(dayNumber))
	directionalLight.rotation_degrees.x = -1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	
	timeText.clear()
	timeLeft = endOfDayTime - time
	timeText.add_text("Time left in Day: " + str(timeLeft as int)	)
	
	_check_time_states(delta)
	_manage_Lighting_with_Time()
	
			
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
		
func _check_time_states(delta):
	if !endOfDay:
		if time > endOfDayTime:
			endOfDay = true
			currentTimeStates = TIME_STATES.FadeToBlackTime
			
	match currentTimeStates:
		TIME_STATES.GameTime:
			if !timePaused:
				if !endOfDay:
					time += delta
					timeLeft = endOfDayTime - time
					
		TIME_STATES.FadeToBlackTime:
			fadeToBlackTime -= delta
			if fadeToBlackTime > 0:			
				colorRect.color.a += 0.005
			else:
				get_tree().call_group("flower_brains", "_decrease_health")
				_reset_day()
				currentTimeStates = TIME_STATES.FadeToGameTime
				
		TIME_STATES.FadeToGameTime:
			fadeToNormalTime -= delta
			if fadeToNormalTime > 0:
				colorRect.color.a -= 0.005
			else:
				currentTimeStates = TIME_STATES.GameTime
			
		
func _reset_day():
	player.global_translation = Vector3(17,1.804,2)
	fadeToNormalTime = 4
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
