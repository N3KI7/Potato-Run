extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var deal_damage = $DealDamage/DealDamage
@onready var deal_damage_long = $DealDamage/DealDamageLong
@onready var get_damage = $GetDamage/GetDamage
@onready var deal_damage_area = $DealDamage
@onready var collision_shape_2d = $CollisionShape2D



const SPEED = 50.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var idle_timer = 0.0
var flipped = false

func _physics_process(delta):
		
	if idle_timer >= 10.0:
		var direction
		if flipped:
			direction = 1
			flipped = true
		else:
			direction = -1
		
		animated_sprite_2d.play("walk")
		deal_damage.disabled = true
		deal_damage_long.disabled = false
		get_damage.position.y = -4.75
		velocity.x = direction*SPEED
	
	else:
		velocity.x = 0.0
		animated_sprite_2d.play("idle")
		get_damage.position.y = -10.0
		deal_damage.disabled = false
		deal_damage_long.disabled = true
	
	idle_timer += 0.1
	move_and_slide()

func wait_and_turn():
	animated_sprite_2d.play("idle")
	get_damage.position.y = -10.0
	deal_damage.disabled = false
	deal_damage_long.disabled = true
	


func _on_get_damage_body_entered(body):
	if body.name == "Player":
		body.velocity.y = -300
	queue_free()


func _on_deal_damage_body_entered(body):
	if body.name == "Player":
		body.damage()
		if body.position.x < position.x:
			body.velocity.y = -300
			body.velocity.x = -500  # Player is to the left, move to the left
		else:
			body.velocity.y = -300
			body.velocity.x = 500   # Player is to the right, move to the right

func touched_aibox():
	idle_timer = 0.0
	if flipped:
		flipped = false
		animated_sprite_2d.flip_h = true
	else:
		flipped = true
		animated_sprite_2d.flip_h = false
