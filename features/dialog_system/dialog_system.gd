extends Node

signal answer_given(response_type)
 

class Character:
	var name := "Rose"
	var portrait := preload("res://assets/images/rose.png")
	
	func get_name():
		return name
	
	func get_portrait():
		return portrait
	
	func get_familiarity():
		return 0
	
	func get_attraction():
		return 0.5


onready var _interface : DialogInterface = get_node("CanvasLayer/DialogInterface")

const BAD = 0
const NEUT = 1
const GOOD = 2

# Relationship (0 - 1), Attraction (0 - 1), Dialog (String)
var dialogs = [
	[ 0, 0.5, "Hi there", [ "Hey, sexy ;)", BAD ], [ "Hello, how are you?", GOOD ], [ "Fuck off", BAD ] ],
]

var _current_dialog = null


#-------------------------------------------------------------------------------
func _on_character_talked_to(character):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_interface.show()
	_interface.set_character_details(character.get_name(), character.get_portrait())
	_current_dialog = _find_dialog(character)
	_interface.set_character_dialog(_current_dialog.line)
	for i in _current_dialog.responses.size():
		_interface.set_answer_dialog(i, _current_dialog.responses[i][0])


#-------------------------------------------------------------------------------
func _find_dialog(character):
	var picked = dialogs[0]
	return {
		line = picked[2],
		responses = picked.slice(3, 5),
	}


#-------------------------------------------------------------------------------
func _on_Timer_timeout():
	_on_character_talked_to(Character.new())


#-------------------------------------------------------------------------------
func _on_DialogInterface_answer_given(answer_no):
	emit_signal("answer_given", _current_dialog.responses[answer_no][1])
	print(_current_dialog.responses[answer_no][0])
	print(_current_dialog.responses[answer_no][1])


#-------------------------------------------------------------------------------
