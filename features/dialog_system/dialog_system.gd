extends Node

signal answer_given(response_type)

onready var _dialogs = get_node("Dialogs").dialogs
onready var _interface : DialogInterface = get_node("CanvasLayer/DialogInterface")

var _current_character = null
var _current_dialog = null


#-------------------------------------------------------------------------------
func _on_character_talked_to(character):
	_current_character = character
	_interface.show()
	_interface.set_character_name(character.get_name())
	_current_dialog = _find_dialog(character)
	_interface.set_character_dialog(_current_dialog.line)
	for i in _current_dialog.responses.size():
		_interface.set_answer_dialog(i, _current_dialog.responses[i][0])


#-------------------------------------------------------------------------------
func _find_dialog(character):
	var picked = _dialogs[0]
	return {
		line = picked[2],
		responses = picked.slice(3, 5),
	}


#-------------------------------------------------------------------------------
func _on_DialogInterface_answer_given(answer_no):
	emit_signal("answer_given", _current_dialog.responses[answer_no][1])
	print(_current_dialog.responses[answer_no][0])
	print(_current_dialog.responses[answer_no][1])
	_current_character._on_dialogue_response_recieved(_current_dialog.responses[answer_no][1])


#-------------------------------------------------------------------------------
