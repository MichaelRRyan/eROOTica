extends StaticBody3D

@onready var compost_label:= get_node("lablel")


func _ready():
	compost_label.hide()



func area_shape_entered_by_player(area_rid, area, area_shape_index, local_shape_index):
	compost_label.show()


func area_shape_exited_by_player(area_rid, area, area_shape_index, local_shape_index):
	compost_label.hide()
