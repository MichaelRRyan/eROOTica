extends Spatial

var position: Vector3 = Vector3(0,0,0)

onready var well_can := get_node("CanSprite")
var player_in_proximity: bool = false;

func _ready():
	pass # Replace with function body.



func _on_Area_body_entered(body):
	print("can entered")
	player_in_proximity = true;
	
	
func _on_Area_body_exited(body):
	print("can exited")
	player_in_proximity = false;
	
	
