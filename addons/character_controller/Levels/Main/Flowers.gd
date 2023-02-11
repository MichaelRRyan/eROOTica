extends Node
# fertilizer signals will signal to both all the flowers and player that fertilizeris 
# empty/full and can/ can't be used
signal _fertilizer_is_full
signal _fertilizer_is_empty


func _ready():
	pass # Replace with function body.





func _fertilizer_full():
	emit_signal("_fertilizer_is_full")
	print("flowers know fertilizer is full")


func _fertilizer_emptied():
	emit_signal("_fertilizer_is_empty")
	print("flowers know fertilizer is empty")
