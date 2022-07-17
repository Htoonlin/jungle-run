extends CanvasLayer

signal start

onready var tween = $Tween
onready var start_menu = $Start
onready var game_over_menu = $GameOver

var started = false

func start():
	started = true
	tween.interpolate_property(start_menu, "modulate:a", 1, 0, 1)
	tween.start()
	emit_signal("start")
	
func _input(event):
	if !started and (event.is_action_pressed("tap") or event is InputEventScreenTouch):
		start()

func game_over():
	start_menu.hide()
	game_over_menu.show()

func _on_Restart_pressed():
	get_tree().reload_current_scene()
