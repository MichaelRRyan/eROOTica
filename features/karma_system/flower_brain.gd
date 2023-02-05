extends Node2D

signal talked_to(me)


onready var flower_face_sprites = []
#default
var flower_face_texture = load("res://assets//images//faces//neutral.png")

#Constants
var MAX_INTEREST_LEVEL = 1
var MIN_INTEREST_LEVEL = 0
var MAX_HEALTH_LEVEL = 1
var MIN_HEALTH_LEVEL = 0
var MAX_KARMA = 1
var MIN_KARMA = 0

#Response Enums
enum Response {
	NEUTRAL_RESPONSE = 0,
	POSITIVE_RESPONSE = 1,
	NEGATIVE_RESPONSE = 2
}

#PlantFace enum for image change
enum PlantFaces {
	AHEGAO = 0,
	ANGRY = 1,
	CLOSED = 2,
	DROWSEY = 3,
	HAPPY = 4,
	NEUTRAL = 5,
	SAD = 6,
	SHOCK = 7,
	TALKING = 8
}

#these variables will be in the range 0 - 1
var currentFlowerInterest = MAX_INTEREST_LEVEL / 2.0
var currentFlowerHealth = MAX_HEALTH_LEVEL / 2.0
var currentPositiveFlowerKarma = MAX_KARMA / 2.0
var currentNegativeFlowerKarma = MAX_KARMA / 2.0
var familiarity = 0 # How much you've talked to them.

var interestIncrease = 0.25
var waterHealthIncrease = 0.1
var foodHealthIncrease = 0.3
var positiveKarmaIncrease = 0.1
var negativeKarmaIncrease = 0.1

var flowerHealthDecrement = 0.1

var character_name : String = "Rose"


# Called when the node enters the scene tree for the first time.
func _ready():
	var systems = get_tree().get_nodes_in_group("dialog_system")
	if systems and !systems.empty():
		var dialog_system = systems.front()
		var _r = connect("talked_to", dialog_system, "_on_character_talked_to")
	

func talked_to():
	emit_signal("talked_to", self)
	
	
func set_name(char_name):
	character_name = char_name
	
	if character_name == "Bella & Donna":
		flower_face_sprites.append(get_node(("../BelladonnaFace1")))
		flower_face_sprites.append(get_node(("../BelladonnaFace2")))
	elif character_name == "Rose":
		flower_face_sprites.append(get_node(("../RoseFace")))
	elif character_name == "Poppy":
		flower_face_sprites.append(get_node(("../Face")))
		get_node("../BobbyFace").show()
	else:
		flower_face_sprites.append(get_node(("../Face")))
	
	for face in flower_face_sprites:
		face.show()
	

func get_name():
	return character_name
	

func get_familiarity():
	return familiarity


func get_attraction():
	return currentFlowerInterest


func _on_water_received():
	currentFlowerHealth += waterHealthIncrease
	print("water receieved")
	
	
func _on_food_received():
	currentFlowerHealth += foodHealthIncrease
	print("food receieved")
	
	
func answer_given(response, new_familiarity):
	familiarity = new_familiarity
	
	var interestAffector = 0.05
	match response:
		Response.NEUTRAL_RESPONSE:
			pass
		Response.POSITIVE_RESPONSE:
			interestAffector *= (currentPositiveFlowerKarma + currentFlowerHealth)
			currentPositiveFlowerKarma += positiveKarmaIncrease
		Response.NEGATIVE_RESPONSE:
			interestAffector *= -(currentNegativeFlowerKarma + (1 - currentFlowerHealth))
			currentNegativeFlowerKarma += negativeKarmaIncrease
			
	currentFlowerInterest += interestAffector
	print("Interest: " + str(currentFlowerInterest) + " Familiarity: " + str(familiarity))

func _decrease_health():
	print(currentFlowerHealth)
	currentFlowerHealth -= flowerHealthDecrement
	print(currentFlowerHealth)
	
func _process(delta):
	_update_current_face()
	
func _update_current_face():

	var rangeOfInterest = 0.14
	var midPointOfInterest = MAX_INTEREST_LEVEL / 2.0
	var plantFace = PlantFaces.NEUTRAL
	
	
	if currentFlowerInterest > midPointOfInterest - rangeOfInterest \
	&& currentFlowerInterest < midPointOfInterest + rangeOfInterest:
		plantFace = PlantFaces.NEUTRAL
		
		#negative range
	if currentFlowerInterest < midPointOfInterest \
	&& currentFlowerInterest > midPointOfInterest - (rangeOfInterest * 2):
		plantFace = PlantFaces.SAD	
		
	if currentFlowerInterest < midPointOfInterest - rangeOfInterest \
	&& currentFlowerInterest > midPointOfInterest - (rangeOfInterest * 3):
		plantFace = PlantFaces.CLOSED
		
	if currentFlowerInterest < midPointOfInterest - rangeOfInterest * 2 \
	&& currentFlowerInterest > MIN_INTEREST_LEVEL:
		plantFace = PlantFaces.ANGRY	
		
		#positive range
	if currentFlowerInterest > midPointOfInterest \
	&& currentFlowerInterest < midPointOfInterest + (rangeOfInterest * 2):
		plantFace = PlantFaces.TALKING
		
	if currentFlowerInterest > midPointOfInterest + rangeOfInterest \
	&& currentFlowerInterest < midPointOfInterest + (rangeOfInterest * 3):
		plantFace = PlantFaces.HAPPY
		
	if currentFlowerInterest > midPointOfInterest + rangeOfInterest * 2 \
	&& currentFlowerInterest < MAX_INTEREST_LEVEL:
		plantFace = PlantFaces.AHEGAO
		
	_apply_plant_face(plantFace)
	
func _apply_plant_face(plantFaceEnum):
	match plantFaceEnum:
		PlantFaces.AHEGAO:
			flower_face_texture = load("res://assets//images//faces//ahegao.png")
			pass
		PlantFaces.ANGRY:
			flower_face_texture = load("res://assets//images//faces//angry.png")
			pass
		PlantFaces.CLOSED:
			flower_face_texture = load("res://assets//images//faces//closed.png")
			pass
		PlantFaces.DROWSEY:
			flower_face_texture = load("res://assets//images//faces//drowsey.png")
			pass
		PlantFaces.HAPPY:
			flower_face_texture = load("res://assets//images//faces//happy.png")
			pass
		PlantFaces.NEUTRAL:
			flower_face_texture = load("res://assets//images//faces//neutral.png")
			pass
		PlantFaces.SAD:
			flower_face_texture = load("res://assets//images//faces//sad.png")
			pass
		PlantFaces.SHOCK:
			flower_face_texture = load("res://assets//images//faces//shock.png")
			pass
		PlantFaces.TALKING:
			flower_face_texture = load("res://assets//images//faces//talking.png")
			pass
	
	for face in flower_face_sprites:
		face.set_texture(flower_face_texture)
	
