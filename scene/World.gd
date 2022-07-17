extends Node


onready var player = $Player
onready var ground = $Ground
onready var fruit_spawner = $FruitSpawner
onready var rock_spawner = $RockSpawner
onready var menu = $Menu

func _ready():
	pass #Replace with function body.

func _on_Player_game_over():
	ground.stop()
	rock_spawner.stop()
	fruit_spawner.stop()
	menu.game_over()

func _on_Menu_start():
	player.run()
	ground.run()
	rock_spawner.start()
	fruit_spawner.start()
