extends CharacterBody2D

@export var speed: int = 400
@onready var hit_sound = $hitSound
var can_collide = true

func _ready():
	self.position = get_viewport_rect().size / 2
	await get_tree().create_timer(0.5).timeout
	velocity = Vector2(randi_range(-350, 350), speed)
	hit_sound.volume_db = linear_to_db(Music.game_vol)

func _physics_process(delta):
	var collision_info = get_last_slide_collision()
	if collision_info and can_collide:
		can_collide = false
		var normal = collision_info.get_normal()
		hit_sound.set_pitch_scale(randf_range(0.75, 1.25))
		hit_sound.play()
		velocity = velocity.bounce(normal)
		await get_tree().create_timer(delta).timeout
		can_collide = true
	
	velocity = velocity.normalized() * speed
	move_and_slide()
