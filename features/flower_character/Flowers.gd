extends Node


# signals to flowers whether resource is full or not
signal _fertilizer_is_full_from_flowerbed
signal _fertilizer_is_empty_from_flowerbed
signal _water_can_filled_from_flowerbed
signal _water_can_emptied_from_flowerbed

# signals to flower whether resource is equiped
signal _fertilizer_equiped_from_flowerbed
signal _fertilizer_unequiped_from_flowerbed
signal _water_can_equiped_from_flowerbed
signal _water_can_unequiped_from_flowerbed


func _water_can_filled_from_can():
	print("flower bed knows water is full")
	emit_signal("_water_can_filled_from_flowerbed")


func _water_can_emptied_from_individual_flower():
	print("flower bed knows water has been used on an individual flower")
	emit_signal("_water_can_emptied_from_flowerbed")


func _fertilizer_full_from_can():
	print("flower bed knows fertilizer is full")
	emit_signal("_fertilizer_is_full_from_flowerbed")


func _fertilizer_emptied_from_individual_flower():
	print("flower bed knows fertilizer is empty")
	emit_signal("_fertilizer_is_empty_from_flowerbed")


func _fertilizer_equiped_from_can():
	print("flower bed knows fertilizer is equiped")
	emit_signal("_fertilizer_equiped_from_flowerbed")


func _fertilizer_unequiped_from_can():
	print("flower bed knows fertilizer is unequiped")
	emit_signal("_fertilizer_unequiped_from_flowerbed")


func _water_can_equiped_from_can():
	print("flower bed knows water is equiped")
	emit_signal("_water_can_equiped_from_flowerbed")


func _water_can_unequiped_from_can():
	print("flower bed knows water is unequiped")
	emit_signal("_water_can_unequiped_from_flowerbed")
