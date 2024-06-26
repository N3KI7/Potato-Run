extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var idle_timer = 0.0
var flipped = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if idle_timer >= 10.0:
		var direction
		if flipped:
			direction = 1
			flipped = true
		else:
			direction = -1
		
		animated_sprite_2d.play("walk")
		velocity.x = direction*SPEED
	
	else:
		velocity.x = 0.0
		animated_sprite_2d.play("idle")
	print("idle_timer: ", idle_timer)
	
	idle_timer += 0.1
	move_and_slide()

func wait_and_turn():
	animated_sprite_2d.play("idle")
	


func _on_get_damage_body_entered(body):
	pass # Replace with function body.


func _on_deal_damage_body_entered(body):
	if body.name == "Player":
		if body.position.x < position.x:
			body.velocity.y = -400
			body.velocity.x = -500  # Player is to the left, move to the left
		else:
			body.velocity.y = -400
			body.velocity.x = 500   # Player is to the right, move to the right

func touched_aibox():
	idle_timer = 0.0
	if flipped:
		flipped = false
		animated_sprite_2d.flip_h = true
	else:
		flipped = true
		animated_sprite_2d.flip_h = false
