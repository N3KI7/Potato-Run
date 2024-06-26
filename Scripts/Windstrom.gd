extends Area2D

@onready var animated_sprite_2d = $AnimatedSprite2D


var body_inside = false
var bodies_inside = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if !animated_sprite_2d.is_playing():
		animated_sprite_2d.play("gif")
	
	for body in bodies_inside.values():
		body.velocity.y = lerp(body.velocity.y, -300.0, 10.0*delta)

func _on_body_entered(body):
	if body is CharacterBody2D:
		bodies_inside[body.get_instance_id()] = body


func _on_body_exited(body):
	if body is CharacterBody2D:
		bodies_inside.erase(body.get_instance_id())
