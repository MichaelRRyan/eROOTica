extends Spatial

var position: Vector3 = Vector3(0,0,0)

onready var well_can := get_node("CanSprite")
var well_in_proximity: bool = false;
var water: int = 0


func _ready():
	pass # Replace with function body.



func _on_Area_body_entered(body):
	print("can entered")
	well_in_proximity = true;
	
	
func _on_Area_body_exited(body):
	print("can exited")
	well_in_proximity = false;
	
	
func _input(delta):
	if(well_in_proximity):
		if(Input.is_action_pressed("feed")):
			print("You got water from the well")
			water = 100
			
	
