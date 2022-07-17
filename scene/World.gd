extends Node


onready var player = $Player
onready var ground = $Ground
onready var fruit_spawner = $FruitSpawner
onready var rock_spawner = $RockSpawner
onready var menu = $Menu
onready var timer = $Timer
onready var hud = $HUD
onready var background_music = $Music

const FRUIT_START = 15

var play_seconds = 0
var apple_count = 0

func start():
	play_seconds = 0
	apple_count = 0
	background_music.play()
	player.run()
	ground.run()
	rock_spawner.start()
	timer.start()
	get_tree().call_group("clouds", "set_physics_process", true)

func game_over():
	background_music.stop()
	ground.stop()
	rock_spawner.stop()
	fruit_spawner.stop()
	menu.game_over()
	timer.stop()
	get_tree().call_group("clouds", "set_physics_process", false)

func _ready():
	get_tree().call_group("clouds", "set_physics_process", false)

func _physics_process(delta):
	if play_seconds == FRUIT_START:
		fruit_spawner.start()
		
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
