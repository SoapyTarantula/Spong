extends CharacterBody2D

@onready var ball = %Ball
@onready var timer = $Timer
@onready var area = $Area2D
@onready var label = $ScoreLabel

const SPEED = 800
var targetPos: Vector2
@export_category("AI Options")
@export var skill = ["Easy", "Medium", "Hard"]
@export var friction: int = 800
@export var acceleration: int = 1200

func _ready():
	position.x = get_viewport_rect().size.x / 2
	position.y = (get_viewport_rect().size.y * 0 ) + 14 
	friction += randi_range(-100, 100)
	acceleration += randi_range(-100, 100)
	skill = randi_range (0, 2)
	print(str("Opponent skill is set to: ", + skill))
	match skill:
		0:
			friction = 800 
			acceleration = 1200
		1:
			friction = 1200
			acceleration = 1500
		2:
			friction = 1500
			acceleration = 1800
		_:
			friction = 800
			acceleration = 1200

func _process(delta):
	if GM.opponentScore:
		label.text = str(GM.opponentScore)
	else:
		label.text = ""
	handle_movement(delta)

func handle_movement(delta):
	if targetPos:
		velocity.x = move_toward(velocity.x, SPEED * targetPos.x, acceleration * delta)

	if !targetPos:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	move_and_slide()

func _on_timer_timeout():
	targetPos = (ball.position - position).normalized()
