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
var familiarity = 0 # How much you've talked to them.

var interestIncrease = 0.25
var waterHealthIncrease = 0.1
var foodHealthIncrease = 0.3
var positiveKarmaIncrease = 0.1
var negativeKarmaIncrease = 0.1

var character_name : String = "Bella & Donna"


# Called when the node enters the scene tree for the first time.
func _ready():
	var systems = get_tree().get_nodes_in_group("dialog_system")
	if systems and !systems.empty():
		var dialog_system = systems.front()
		var _r = connect("talked_to", dialog_system, "_on_character_talked_to")
	

func talked_to():
	emit_signal("talked_to", self)


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
