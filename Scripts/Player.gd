extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var beach_background = $"../PlayerCamera/BeachBackground"
@onready var player_camera = $"../PlayerCamera"
@onready var level = $"../.."

var potatos_collected = 0

var _fullScreen = DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN
const ORIGIN = {x = 0.0, y = 0.0}
const SPEED = 100.0
const JUMP_VELOCITY = -200.0
var potatoScene = preload("res://Scenes/potato_falling.tscn")

# Blinking
var blink_timer = 0.0
var invincibility_timer = 0.0
var transparent = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
func _process(delta):
	if Input.is_action_just_pressed("fullscreen"):
			if _fullScreen == false:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
				_fullScreen = true
			else:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				_fullScreen = false

func _physics_process(delta):
	# Invincibility blinking
	if invincibility_timer <= 10.0:
		if  transparent and blink_timer > 1.0:
			player_sprite.visible = true
			blink_timer = 0.0
		elif blink_timer > 1.0: 
			player_sprite.visible = true
			blink_timer = 0.5
		blink_timer += 0.1
		invincibility_timer += 0.1
	elif invincibility_timer > 10.0:
		collision_layer = 1
		player_sprite.visible = true
	
	player_camera.position = lerp(player_camera.position, position, 8.0*delta)
	beach_background.position.x = (-0.025*player_camera.position.x)
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		if direction > 0:
			player_sprite.flip_h = false
		else:
			player_sprite.flip_h = true
		if velocity.y <= -50:
			player_sprite.play("hold")
		else:
			player_sprite.play("walk")
		velocity.x = lerp(velocity.x, direction * SPEED, 15.0*delta)
		if velocity.y <= -50:
			player_sprite.play("hold")
		
	else:
		player_sprite.play("walk")
		player_sprite.stop()
		velocity.x = lerp(velocity.x, 0.0, 15.0*delta)
	
	move_and_slide()

func collect_potato():
	potatos_collected += 1
	print("Potatoes: ", potatos_collected)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("player")
		body.position.x = 0.0
		body.position.y = 0.0

func damage():
	level.spawn_potatoes(potatos_collected)
	potatos_collected = 0
	collision_layer = 2
	blink_timer = 0.0
	invincibility_timer = 0.0
	
	
