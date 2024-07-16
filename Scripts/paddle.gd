extends CharacterBody2D

@export_category("Movement")
@export var speed: int = 4000
@export var acceleration: int = 1500
@export var friction: int = 1000
@export var rotation_speed: float = 180

@onready var rayCastRight = $RayCastRight
@onready var rayCastLeft = $RayCastLeft
@onready var area = $Area2D
@onready var score_label = $ScoreLabel
var moveVec: float
var canMove: bool


func _ready():
	# set position of player paddle at start
	position.x = get_viewport_rect().size.x / 2
	position.y = get_viewport_rect().size.y + -14 #TODO probably figure out a better way to do this

func _process(delta):
	if GM.score == 0:
		score_label.text = ""
	else:
		score_label.text = str(GM.score)
	handle_movement(delta)
	get_input()
	self.rotation_degrees += _rotate_paddle() * delta * rotation_speed
	if Input.is_action_just_pressed("ui_accept"):
		self.rotation_degrees = 0
	if Input.is_action_just_pressed("menuButton"):
		get_tree().change_scene_to_file("res://Scenes/menu.tscn")
	
func handle_movement(delta):
	position.y = get_viewport_rect().size.y + -14
	if moveVec:
		velocity.x = move_toward(velocity.x, speed * moveVec, acceleration * delta)

	if !moveVec:
		velocity.x = move_toward(velocity.x, 0, friction * delta)
	move_and_slide()

func get_input():
	moveVec = Input.get_axis("Left", "Right")
	
func _rotate_paddle() -> float:
	var rotate_amount = Input.get_axis("rotate_left", "rotate_right")
	return rotate_amount
