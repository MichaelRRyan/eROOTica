extends Node
# fertilizer signals will signal to both all the flowers and player that fertilizeris 
# empty/full and can/ can't be used
signal _fertilizer_is_full_from_flowerbed
signal _fertilizer_is_empty_from_flowerbed

signal _water_can_filled_from_flowerbed
signal _water_can_emptied_from_flowerbed

func _ready():
	pass # Replace with function body.







func _water_can_filled_from_can():
	print("flower bed knows water is full")
	emit_signal("_water_can_filled_from_flowerbed")


func _water_can_emptied_from_individual_flower():
	print("flower bed knows water has been used on an individual flower")
	emit_signal("_water_can_emptied_from_flowerbed")
