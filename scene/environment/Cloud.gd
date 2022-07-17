extends Area2D

onready var sprite = $Sprite

var speed = 10
var screen_size

func _ready():
	randomize()
	screen_size = get_viewport_rect().size

func restart():
	sprite.frame = randi() % sprite.hframes
	global_position.x = randi() % 500 + screen_size.x
	
func _physics_process(delta):
	position.x -= speed * delta
	if global_position.x <= -50:
		restart()
