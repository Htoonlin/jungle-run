extends Position2D

signal spawn(obj)

export(PackedScene) var EnemyObject
export var pos_from = 0
export var pos_to = 100
export var second = 1.0

onready var timer = $Timer

func spawn_enemy():
	var enemy = EnemyObject.instance()
	enemy.position.x = randi() % pos_to + pos_from
	add_child(enemy)
	emit_signal("spawn", enemy)
	
func start():
	timer.start()

func stop():
	timer.stop()

func _ready():
	randomize()
	$Timer.wait_time = second


func _on_Timer_timeout():
	spawn_enemy()
