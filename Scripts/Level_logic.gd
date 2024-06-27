extends Node2D

@onready var player = $world/Player
const POTATO_FALLING = preload("res://Scenes/potato_falling.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_potatoes(40)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_potatoes(amount: int):
	while amount > 0:
		var instance = POTATO_FALLING.instantiate()
		instance.position = player.position
		instance.position.x += randf_range(-10.0, 10.0)
		instance.position.y += randf_range(-5.0, -10.0)
		add_child(instance)
		amount -= 1
