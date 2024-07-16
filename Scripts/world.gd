extends Node2D

signal paddle_scored
signal opponent_scored

@onready var opponentWin = $Sounds/opponentScored
@onready var paddleWin = $Sounds/paddleScored

func _ready():
	#Put the score bounds correctly at the top & bottom of the screen
	%Top.position.y = get_viewport_rect().size.y * 0
	%Bottom.position.y = get_viewport_rect().size.y + 20
	
	#Put the sides in place using the same method as above, except that I'm doing it manually on the left wall.
	$WallLeft.position.x = (get_viewport_rect().size.x * 0) - 40
	$WallRight.position.x = get_viewport_rect().size.x
	
	GM.can_score = true

func _on_top_area_entered(area):
	if area.get_parent().name == "Ball":
		emit_signal("paddle_scored")
		#print("top")
		paddleWin.play()
		if GM.can_score:
			GM.score += 1
		GM.can_score = false
		GM.start_over()

func _on_bottom_area_entered(area):
	if area.get_parent().name == "Ball":
		emit_signal("opponent_scored")
		#print("bottom")
		opponentWin.play()
		if GM.can_score:
			GM.opponentScore += 1
		GM.can_score = false
		GM.start_over()
