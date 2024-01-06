class_name DialogInterface
extends Control

signal answer_given(answer_no)
signal continue_pressed()


@onready var name_label = get_node("NamePanel/Name")
@onready var character_dialog = get_node("DialogPanel/Label")
@onready var answers = [
	get_node("Answers/Answer1"),
	get_node("Answers/Answer2"),
	get_node("Answers/Answer3"),
]


#-------------------------------------------------------------------------------
func _ready():
	for i in answers.size():
		answers[i].connect("pressed",Callable(self,"_on_AnswerButton_pressed").bind(i))


#-------------------------------------------------------------------------------
func _on_AnswerButton_pressed(button_no : int):
	emit_signal("answer_given", button_no)


#-------------------------------------------------------------------------------
func display():
	visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


#-------------------------------------------------------------------------------
func set_character_name(character_name : String) -> void:
	name_label.text = character_name


#-------------------------------------------------------------------------------
func set_character_dialog(dialog : String) -> void:
	character_dialog.text = dialog


#-------------------------------------------------------------------------------
func set_answer_dialog(answer_no : int, dialog : String) -> void:
	if answer_no < 0 or answer_no > 2:
		print_debug("Answer number must be 0 - 2 when setting dialog.")
		return
	
	answers[answer_no].get_node("Label").text = dialog
	$Answers.show()
	$ContinueBox.hide()


#-------------------------------------------------------------------------------
func display_follow_up(dialog : String) -> void:
	character_dialog.text = dialog
	$Answers.hide()
	$ContinueBox.show()


#-------------------------------------------------------------------------------
func _on_Continue_pressed():
	emit_signal("continue_pressed")


#-------------------------------------------------------------------------------
