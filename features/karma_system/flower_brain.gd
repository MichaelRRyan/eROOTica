extends Node
class_name FlowerBrain

signal talked_to(me)

@onready var FLOWER_FACES = {
	"Bella & Donna": [ 
		get_node("../Faces/Bella"),
		get_node("../Faces/Donna")
	],
	"Rose": [ 
		get_node("../Faces/Rose"),
	],
	"Poppy": [ 
		get_node("../Faces/Poppy"),
		get_node("../Faces/Bobby"),
	],
	"Sunflower": [ 
		get_node("../Faces/Sunflower"),
	],
}

var FLOWER_BODIES_TEXTURES = {
	"Bella & Donna": [ 
		"res://assets/images/nightshade.png",
		"res://assets/images/nightshade-wilting.png",
		"res://assets/images/nightshade-wilted.png",
	],
	"Rose": [ 
		"res://assets/images/rose.png",
		"res://assets/images/rose-wilting.png",
		"res://assets/images/rose-wilted.png",
	],
	"Poppy": [ 
		"res://assets/images/poppy.png",
		"res://assets/images/poppy-wilting.png",
		"res://assets/images/poppy-wilted.png",
	],
	"Sunflower": [ 
		"res://assets/images/sunflower.png",
		"res://assets/images/sunflower-wilting.png",
		"res://assets/images/sunflower-wilted.png",
	],
}

enum PLANT_HEALTH_STATES{
	HEALTHY = 0,
	WILTING = 1,
	WILTED = 2,
}

@onready var flower_body = get_node("../FlowerSprite")

var flower_face_sprites = []
var flower_body_textures = []

var body_texture
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

var _character_name : String = "Rose"


# Called when the node enters the scene tree for the first time.
func _ready():
	var systems = get_tree().get_nodes_in_group("dialog_system")
	if systems and !systems.is_empty():
		var dialog_system = systems.front()
		var _r = connect("talked_to",Callable(dialog_system,"_on_character_talked_to"))
	

func talk():
	emit_signal("talked_to", self)
	
	
func setup(character_name):
	_character_name = character_name
	
	flower_face_sprites = FLOWER_FACES[_character_name]
	for face in flower_face_sprites:
		face.show()
		
	flower_body_textures = FLOWER_BODIES_TEXTURES[_character_name]

	body_texture = flower_body_textures[PLANT_HEALTH_STATES.WILTED]
	flower_body.set_texture(load(body_texture))
	
	

func get_flower_name():
	return _character_name
	

func get_familiarity():
	return familiarity


func get_attraction():
	return clamp(currentFlowerInterest, 0.0, 1.0)


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
	
func _process(_delta):
	_update_current_face()
	_update_current_plant_body()
	#test code for all flowers
	if Input.is_action_just_pressed("jump"):
		currentFlowerHealth -= 0.1
	
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
		
	_apply_plant_face(plantFace)
	
func _update_current_plant_body():
	var midPointOfHealth = MAX_INTEREST_LEVEL / 2.0
	var plantHealth = PLANT_HEALTH_STATES.HEALTHY
	
	if currentFlowerHealth >= midPointOfHealth:
		plantHealth = PLANT_HEALTH_STATES.HEALTHY
		
	if currentFlowerHealth < midPointOfHealth \
	&& currentFlowerHealth > 0:
		plantHealth = PLANT_HEALTH_STATES.WILTING
		
	if currentFlowerHealth <= 0:
		plantHealth = PLANT_HEALTH_STATES.WILTED
		flower_face_sprites = FLOWER_FACES[_character_name]
		for face in flower_face_sprites:
			face.hide()
		
		
	_apply_plant_body(plantHealth)
		
func _apply_plant_body(plantHealthEnum):
		flower_body.set_texture(load(flower_body_textures[plantHealthEnum]))
		
	
func _apply_plant_face(plantFaceEnum):
	match plantFaceEnum:
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
	
