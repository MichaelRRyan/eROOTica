extends VBoxContainer


onready var answers = [
	get_node("TextureButton"),
	get_node("TextureButton2"),
	get_node("TextureButton3"),
]


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in answers.size():
		answers[i].connect("pressed", self, "_on_TextureButtonPressed", [i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
