extends CharacterBody2D

@onready var player_sprite = $AnimatedSprite2D
@onready var beach_background = $"../BeachBackground"
@onready var player_camera = $"../PlayerCamera"




const SPEED = 100.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	
	player_camera.position = lerp(player_camera.position, position, 8.0*delta)
	# player_camera.position.x = (0.1*player_camera.position.x)+position.x
	
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
		player_sprite.play("walk")
		if direction > 0:
			player_sprite.flip_h = false
		else:
			player_sprite.flip_h = true
		velocity.x = direction * SPEED
	else:
		player_sprite.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
