extends Area2D

@onready var potato_collectable = $PotatoCollectable
@onready var character_body_2d = get_parent()

var sin_timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if character_body_2d and character_body_2d is CharacterBody2D:
		if character_body_2d.timer >= 49.0:
			queue_free()
	
	print(sin(2.5*sin_timer))
	potato_collectable.position.y = sin(2.5*sin_timer)
	sin_timer += delta

func _on_body_entered(body):
	if body.name == "Player":
		body.collect_potato()
		queue_free()
