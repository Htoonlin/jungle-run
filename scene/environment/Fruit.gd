extends Area2D

onready var sprite = $Sprite

var speed = 500

func _ready():
	randomize()
	sprite.frame = randi() % sprite.hframes
	
func _physics_process(delta):
	position.x -= speed * delta
	if global_position.x <= -20:
		queue_free()

func _on_Fruit_body_entered(body):
	if body is Player and body.has_method("hit"):
		print("Got apple!")
		body.hit(Player.HitType.APPLE)
		queue_free()
