extends Control

@onready var main_menu_texture = $MainMenuTexture

var _fullScreen = false
var defaultWindowWidth = 1152.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
		if _fullScreen == false:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			_fullScreen = true
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_fullScreen = false
	
	var currentWindowWidth = get_viewport().size.x
	main_menu_texture.scale.x = currentWindowWidth/defaultWindowWidth
	main_menu_texture.scale.y = currentWindowWidth/defaultWindowWidth


func _on_play_button_down():
	get_tree().change_scene_to_file("res://Scenes/Level_1.tscn")

func _on_exit_button_down():
	get_tree().quit()
