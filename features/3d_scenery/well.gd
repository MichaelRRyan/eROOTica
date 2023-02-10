extends StaticBody

var player_in_proximity: bool = false
onready var well_label:= get_node("label2")

func _ready():
	well_label.hide()


func _on_Area_body_entered(player):
	well_label.show()
	print("enter")

func _on_Area_body_exited(player):
	well_label.hide()
	print("exit")


func player_in_proximity_to_well(body):
	well_label.show()


func player_exited_proximity_of_well(body):
	well_label.hide()
