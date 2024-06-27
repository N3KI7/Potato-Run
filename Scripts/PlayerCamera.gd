extends Camera2D

var rezoom_enabled = true

const zoom_factor = 236.30

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if rezoom_enabled:
		var current_viewport_width = get_viewport().size.x
		print("viewport_width: ", current_viewport_width)
		var new_zoom_x = current_viewport_width/zoom_factor
		print("zoom: ", new_zoom_x)
		zoom = Vector2(new_zoom_x, new_zoom_x)
		
