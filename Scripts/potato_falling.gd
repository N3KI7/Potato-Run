extends CharacterBody2D

@onready var potato_collectable = $Potato_Collectable
@onready var collision_shape_2d = $CollisionShape2D


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")/3

var time_to_live = 20.0
var timer = 0.0
var blink_timer = 0.0
var blink_visible = false
var collision_decided = false

func _ready():
	velocity.x = randf_range(-150.0, 150.0)
	velocity.y = randf_range(-100.0, -200.0)

func _physics_process(delta):
	if timer >= 2.5 and !collision_decided:
		collision_shape_2d.disabled = randf_range(-5.0, 5.0) >= randf_range(-5.0, 5.0)
		collision_decided = true
	if timer >= time_to_live:
		queue_free()
	
	potato_physics(delta)

func potato_physics(delta):
	# Physik
	if !is_on_floor():
		velocity.y += gravity*delta
	else:
		velocity.x = lerp(velocity.x, 0.0, 5.0*delta)
	
	timer += 0.1
	blink_timer += 0.1
	
	if blink_timer >= 3.0:
		if blink_visible:
			potato_collectable.visible = false
			blink_visible = false
			blink_timer = 1.5
		else:
			potato_collectable.visible = true
			blink_visible = true
			blink_timer = 0.0
	
	move_and_slide()

func get_timer():
	return timer


func _on_potato_collectable_body_entered(body):
	if timer >= 5.0:
		if body.name == "Player":
			body.collect_potato()
			queue_free()
