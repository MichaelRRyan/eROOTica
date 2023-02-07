extends Node

onready var _dialogs = get_node("Dialogs").dialogs
onready var _interface : DialogInterface = get_node("CanvasLayer/DialogInterface")
onready var _time_manager = get_node("../TimeManager")

var _current_dialog = null
var _current_character = null

signal _leaving_dialogue


#-------------------------------------------------------------------------------
func _on_character_talked_to(character):
	_current_character = character
	_interface.show()
	_interface.set_character_name(character.get_name())
	_current_dialog = _find_dialog(character)
	_time_manager._pause_time_dependencies()
	
	if _current_dialog:
		_interface.set_character_dialog(_current_dialog.line)
		for i in _current_dialog.responses.size():
			_interface.set_answer_dialog(i, _current_dialog.responses[i][0])
	else:
		_interface.display_follow_up("I can't think of anything to say.")
		print_debug("RAN OUT OF DIALOG")


#-------------------------------------------------------------------------------
func _find_dialog(character):
	var char_dialogs = _dialogs[character.get_name()]
	var next_familiarity = character.get_familiarity() + 1
	
	var options = []
	for dialog in char_dialogs:
		if dialog[0] == next_familiarity:
			options.append(dialog)
	
	var dialog = null
	if options.size() == 1:
		dialog = options[0]
		
	elif not options.empty():
		var closest_dist = 1
		
		for option in options:
			var dist = abs(option[1] - character.get_attraction())
			if dist < closest_dist:
				closest_dist = dist
				dialog = option
		
	if dialog != null:
		return {
			line = dialog[2],
			responses = dialog.slice(3, 5),
			familiarity = dialog[0],
		}
	
	return null


#-------------------------------------------------------------------------------
func _on_DialogInterface_answer_given(answer_no):
	var answer : Array = _current_dialog.responses[answer_no]
	_current_character.answer_given(answer[1], _current_dialog.familiarity)
	
	if answer.size() == 3:
		_interface.display_follow_up(answer[2])
	else:
		_interface.hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		emit_signal("_leaving_dialogue")
		_time_manager._unpause_time_dependencies()
		


#-------------------------------------------------------------------------------
func _on_DialogInterface_continue_pressed():
	_interface.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	emit_signal("_leaving_dialogue")
	_time_manager._unpause_time_dependencies()
	


#-------------------------------------------------------------------------------
