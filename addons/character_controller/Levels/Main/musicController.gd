extends AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	_play_gardening_music()
	pass # Replace with function body.

func _play_dialogue_music():
	stream = load("res://assets/audio/music/seductive.wav")
	play()
	
func _play_gardening_music():
	stream = load("res://assets/audio/music/field.ogg")
	play()
	
func _play_dying_music():
	stream = load("res://assets/audio/music/dying.wav")
	play()


func _in_dialogue():
	_play_dialogue_music()


func _leaving_dialogue():
	_play_gardening_music()
