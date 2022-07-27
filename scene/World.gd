extends Node


onready var player = $Player
onready var ground = $Ground
onready var fruit_spawner = $FruitSpawner
onready var monkey_spawner = $MonkeySpawner
onready var bird_spawner = $BirdSpawner
onready var ground_enemy_spawner = $GroundEnemySpawner
onready var menu = $Menu
onready var timer = $Timer
onready var hud = $HUD
onready var background_music = $Music

const FRUIT_START = 15
const RANDOM_ENEMIES_START = 10
const CHANGE_RANDOME_ENEMIES = 6

var play_seconds = 0
var apple_count = 0
var spawners

func start():
	play_seconds = 0
	apple_count = 0
	background_music.play()
	player.run()
	ground.run()
	ground_enemy_spawner.start()
	timer.start()
	get_tree().call_group("clouds", "set_physics_process", true)

func game_over():
	background_music.stop()
	ground.stop()
	menu.game_over()
	timer.stop()
	get_tree().call_group("spawners", "stop")
	get_tree().call_group("enemies", "set_physics_process", false)
	get_tree().call_group("fruits", "queue_free")
	get_tree().call_group("clouds", "set_physics_process", false)

func _ready():
	randomize()
	spawners = [ground_enemy_spawner, bird_spawner, monkey_spawner]
	get_tree().call_group("clouds", "set_physics_process", false)

func _physics_process(delta):
	if play_seconds == FRUIT_START:
		fruit_spawner.start()
		
	if play_seconds >= RANDOM_ENEMIES_START and (play_seconds % CHANGE_RANDOME_ENEMIES) == 0:
		var spawner_index = randi() % spawners.size()
		for spawner in spawners:
			spawner.stop()
		spawners[spawner_index].start()
		
	
func _on_Player_game_over():
	game_over()

func _on_Menu_start():
	start()

func _on_Timer_timeout():
	play_seconds += 1
	hud.set_timer(play_seconds)


func _on_Player_hit_apple():
	apple_count += 1
	hud.set_fruit(apple_count)
