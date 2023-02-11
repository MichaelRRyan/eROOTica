extends StaticBody

onready var well_label:= get_node("lablel")
signal in_proximity_to_well
signal out_of_proximity_to_well




func _ready():
	well_label.hide()
	

func area_shape_entered_by_player(area_rid, area, area_shape_index, local_shape_index):
	well_label.show()


func area_shape_exited_by_player(area_rid, area, area_shape_index, local_shape_index):
	well_label.hide()
