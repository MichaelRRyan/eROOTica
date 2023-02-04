extends Spatial


var position : Vector3 = Vector3(1, 1, 1)
onready var flower := get_node("FlowerSprite")
onready var text_box:= get_node("Textbox")
var in_range_of_player: bool = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	
	text_box.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




func _on_Area_body_entered(body):
	text_box.show()
	in_range_of_player = true

func _on_Area_body_exited(body):
	text_box.hide()
	in_range_of_player = false
	
	
func _input(delta):
	if(in_range_of_player):
		if(Input.is_action_pressed("feed")):
			print("You fed the flower")

