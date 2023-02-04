extends Node2D

signal talked_to(me)




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

#these variables will be in the range 0 - 1
var currentFlowerInterest = MAX_INTEREST_LEVEL / 2.0
var currentFlowerHealth = MAX_HEALTH_LEVEL / 2.0
var currentPositiveFlowerKarma = MAX_KARMA / 2.0
var currentNegativeFlowerKarma = MAX_KARMA / 2.0

var interestIncrease = 0.25
var waterHealthIncrease = 0.1
var foodHealthIncrease = 0.3
var positiveKarmaIncrease = 0.1
var negativeKarmaIncrease = 0.1

var character_name : String = "Rose"


# Called when the node enters the scene tree for the first time.
func _ready():
	var systems = get_tree().get_nodes_in_group("dialog_system")
	if systems and !systems.empty():
		var dialog_system = systems.front()
		dialog_system.connect("answer_given", self, "_on_dialogue_response_recieved")
		connect("talked_to", dialog_system, "_on_character_talked_to")
	
	#TESTS
	#test_positive_response()
	
	#test_3_positive_responses()
	
	#test_3_negative_responses()
	
	test_strange_case_1()
	

func talked_to():
	emit_signal("talked_to", self)


func get_name():
	return character_name
	

func get_familiarity():
	return 0


func get_attraction():
	return currentFlowerInterest

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_water_received():
	currentFlowerHealth += waterHealthIncrease
	print("water receieved")
	
func _on_food_received():
	currentFlowerHealth += foodHealthIncrease
	print("food receieved")
	
func _on_dialogue_response_recieved(response):

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
	print(currentFlowerInterest)
	
func test_positive_response():
	currentFlowerHealth = 0.7
	currentFlowerInterest = 0.5
	currentNegativeFlowerKarma = 0.5
	currentPositiveFlowerKarma = 0.6
	
	print("Before repsonse: " + str(currentFlowerInterest))
		
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	
	print("Flower Interest: " + str(currentFlowerInterest))
	
	

func test_3_positive_responses():
	
	currentFlowerHealth = 0.5
	currentFlowerInterest = 0.5
	currentNegativeFlowerKarma = 0.5
	currentPositiveFlowerKarma = 0.5
	
	print("Before repsonse: " + str(currentFlowerInterest))
		
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	
	print("Flower Interest: " + str(currentFlowerInterest))
	
func test_3_negative_responses():
	
	currentFlowerHealth = 0.5
	currentFlowerInterest = 0.5
	currentNegativeFlowerKarma = 0.5
	currentPositiveFlowerKarma = 0.5
	
	print("Before repsonse: " + str(currentFlowerInterest))
		
	_on_dialogue_response_recieved(Response.NEGATIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	_on_dialogue_response_recieved(Response.NEGATIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	_on_dialogue_response_recieved(Response.NEGATIVE_RESPONSE)
	
	print("Flower Interest: " + str(currentFlowerInterest))
	
func test_strange_case_1():
	#Flower is dying but your nice
	#You neglected it but havent been mean 
	#And you try to be nice
	currentFlowerHealth = 0.1
	currentFlowerInterest = 0.2
	currentNegativeFlowerKarma = 0.5
	currentPositiveFlowerKarma = 0.7
	
	print("Before repsonse: " + str(currentFlowerInterest))
		
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	print("Flower Health: " + str(currentFlowerHealth))
	
	#Lets say you fed and watered them and you were nice again
	_on_food_received()
	_on_water_received()
	
	print("Flower Health: " + str(currentFlowerHealth))
	
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	
	#Lets say you fed them again and you were nice again
	_on_food_received()
	
	print("Flower Health: " + str(currentFlowerHealth))
	
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	
	#then you were just nice again. this kinda tests if you can bounce out of a despereate situation
	
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))
	
	#test again
	_on_dialogue_response_recieved(Response.POSITIVE_RESPONSE)
	print("Flower Interest: " + str(currentFlowerInterest))


func _on_Timer_timeout():
	talked_to()
