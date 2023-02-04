extends Node2D


#Constants
var MAX_INTEREST_LEVEL = 1
var MIN_INTEREST_LEVEL = 0
var MAX_HEALTH_LEVEL = 0
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
var currentFlowerInterest = MAX_INTEREST_LEVEL / 2
var currentFlowerHealth = MAX_HEALTH_LEVEL / 2
var currentPositiveFlowerKarma = MAX_KARMA / 2
var currentNegativeFlowerKarma = MAX_KARMA / 2

var interestIncrease = 0.25
var waterHealthIncrease = 0.1
var foodHealthIncrease = 0.3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_water_received():
	currentFlowerHealth += waterHealthIncrease
	
func _on_food_received():
	currentFlowerHealth += foodHealthIncrease
	
func _on_dialogue_response_recieved(response):
	match response:
		Response.NEUTRAL_RESPONSE:
			pass
		Response.POSITIVE_RESPONSE:
			currentFlowerInterest += currentPositiveFlowerKarma + currentFlowerHealth
		Response.NEGATIVE_RESPONSE:
			currentFlowerInterest -= currentNegativeFlowerKarma 






