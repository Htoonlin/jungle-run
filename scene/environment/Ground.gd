extends StaticBody2D

class_name Ground

onready var sprite = $Sprite

var speed = 500

func _ready():
	stop()

func stop():
	set_physics_process(false)
	
func run():
	set_physics_process(true)
	
func _physics_process(delta):
	position.x -= speed * delta
	
	if global_position.x <= -320:
		global_position.x = 0
		
