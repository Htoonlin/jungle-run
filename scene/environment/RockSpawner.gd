extends Node2D

signal spawn_rock(rock)

export(PackedScene) var Rock

onready var timer = $Timer

func spawn_rock():
	var rock = Rock.instance()
	rock.position.x = randi() % 300	
	add_child(rock)
	emit_signal("spawn_rock", rock)

func start():
	timer.start()
	
func stop():
	get_tree().call_group("rocks", "set_physics_process", false)
	timer.stop()

func _ready():
	randomize()
		
func _on_Timer_timeout():
	if get_child_count() > 3: return
	spawn_rock()
