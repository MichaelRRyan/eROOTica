extends CanvasLayer

onready var timeText = get_node("RichTextLabel")
onready var timeManager = get_node(("../../TimeManager"))

# Called when the node enters the scene tree for the first time.
func _ready():
	timeText.add_text(str(timeManager.getRemainingTimeLeft())	)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timeText.clear()
	timeText.add_text("Time left in Day: " + str(timeManager.getRemainingTimeLeft() as int))	
	pass
