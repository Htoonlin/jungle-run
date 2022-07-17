extends Node2D

export(PackedScene) var Fruit

onready var timer = $Timer

func spawn_fruit():
	var fruit = Fruit.instance()
	fruit.position.x = randi() % 200	
	add_child(fruit)

func start():
	timer.start()
	
func stop():
	get_tree().call_group("fruits", "set_physics_process", false)
	timer.stop()

func _ready():
	randomize()
		
func _on_Timer_timeout():
	spawn_fruit()
