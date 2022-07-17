extends Area2D

onready var sprite = $Sprite
onready var hit_sound = $HitSound

var speed = 490

func _ready():
	randomize()
	#sprite.frame = randi() % sprite.hframes
	
func _physics_process(delta):
	position.x -= speed * delta
	if global_position.x <= -64:
		queue_free()

func _on_Rock_body_entered(body):
	if body is Player and body.has_method("hit"):
		hit_sound.play()
		body.hit(Player.HitType.ROCK)
		
