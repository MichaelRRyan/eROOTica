extends StaticBody

var player_in_proximity: bool = false
onready var well_label:= get_node("label2")

func _ready():
	well_label.hide()


func _on_Area_body_entered(player):
	well_label.show()

func _on_Area_body_exited(player):
	well_label.hide()
