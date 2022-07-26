extends Area2D

onready var sprite = $Sprite

var speed = 600
	
func _physics_process(delta):
	position.x -= speed * delta
	if global_position.x <= -64:
		queue_free()

func _on_Bird_body_entered(body):
	if body is Player and body.has_method("hit"):
		body.hit(Player.HitType.ENEMY)
