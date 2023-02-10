extends StaticBody
onready var compost_label:= get_node("lablel")


func _ready():
	compost_label.hide()
	
	
	






func player_in_proximity(body):
	compost_label.show()


func player_left_proximity(body):
	compost_label.hide()
