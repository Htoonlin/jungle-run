extends CanvasLayer


onready var fruit = $Fruit
onready var timer = $Timer

func set_timer(seconds):
	var minute = seconds / 60
	var sec = seconds % 60
	timer.text = "%02d:%02d" % [minute, seconds]
	
func set_fruit(count):
	fruit.text = "x %02d" % count
