extends KinematicBody2D

export var jump_power = 1200
export var gravity = 3000

onready var animator = $AnimationPlayer
onready var timer = $Timer

const MOVE_SPEED = 500
var velocity = Vector2.ZERO
var jumping = false

func jump():
	if jumping: return
	jumping = true
	animator.play("Jump")
	velocity.y = jump_power * -1

func idle():
	animator.play("Idle")
	velocity.y = 0
	
func _ready():
	randomize()
	
func _physics_process(delta):
	if jumping:
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP, true)
		
	if is_on_floor():
		if jumping:
			jumping = false
		else:
			idle()

	position.x -= MOVE_SPEED * delta
	if global_position.x <= -50:
		queue_free()
		

func _on_Timer_timeout():
	jump()


func _on_DangerArea_body_entered(body):
	if body is Player and body.has_method("hit"):
		body.hit(Player.HitType.ENEMY)
