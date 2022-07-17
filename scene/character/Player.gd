extends KinematicBody2D

class_name Player

const MOBILES = ["android", "ios"]
enum Style {IDLE, RUN, JUMP, CRAWL, SHOOT, DIE}
enum HitType {ROCK,APPLE}

signal game_over
signal hit_apple

onready var animator = $AnimationPlayer
onready var sprite = $Sprite
onready var jump_sound = $JumpSound

export var jump_speed = -1200
export var gravity = 3000

var die = false
var velocity = Vector2()
var current_style = Style.IDLE
var dragging = false

func idle():
	current_style = Style.IDLE
	animator.play("Idle")

func run():
	if current_style == Style.RUN: return
	current_style = Style.RUN
	animator.play("Run")
	velocity = Vector2.ZERO
	
func jump():
	if current_style == Style.JUMP: return
	print("Jump")
	jump_sound.play()
	current_style = Style.JUMP
	animator.play("Jump")
	velocity.y = jump_speed
	
func crawl():
	if current_style == Style.CRAWL: return
	print("Crawl")
	current_style = Style.CRAWL
	animator.play("Crawl")
	
func shoot():
	print("Shoot")

func game_over():
	die = true
	current_style = Style.DIE
	animator.stop()
	emit_signal("game_over")
	
func hit(type):
	if type == HitType.ROCK:
		game_over()
	elif type == HitType.APPLE:
		emit_signal("hit_apple")
	
func _ready():
	idle()
	
func pc_input(event):
	if event.is_action_pressed("tap"):
		if current_style == Style.IDLE:
			run()
		else:
			shoot()
	elif event.is_action_pressed("up") and current_style != Style.IDLE:
		jump()
	elif event.is_action_pressed("down") and current_style != Style.IDLE:
		crawl()

func mobile_input(event):
	if event is InputEventScreenTouch:
		if current_style == Style.IDLE:
			run()
		else:
			shoot()
	elif event is InputEventScreenDrag:
		print("Event Position => ", event.position)
		print("Event Relative => ", event.relative)
		print("Event Speed => ", event.speed)
		if event.relative.y < 0: 
			jump()
		elif event.relative.y > 0:
			crawl()
	
func _input(event):	
	if current_style == Style.JUMP or die:
		return
		
	if MOBILES.has(OS.get_name().to_lower()):
		mobile_input(event)
	else:
		pc_input(event)
		
func _physics_process(delta):
	if current_style == Style.JUMP:
		velocity.y += gravity * delta
		velocity = move_and_slide(velocity, Vector2.UP, true)
	
	if is_on_floor() and !die:
		if current_style == Style.CRAWL:
			print("Crawling...")
		else:
			run()
	


