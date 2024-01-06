extends MeshInstance3D



func apply_texture(mesh_instance_node, texture_path):
	var texture = ImageTexture.new()
	var image = Image.new()
	image.load(texture_path)
	texture.create_from_image(image)
	if mesh_instance_node.material_override:
		mesh_instance_node.material_override.albedo_texture = texture  


# Called when the node enters the scene tree for the first time.
func _ready():
	apply_texture(self, "res://.import/grassText.png-d1e0c110fdc33924f5e2744cef9c71e1.stex")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

