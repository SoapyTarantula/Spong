extends Node2D

var score: int = 0
var opponentScore: int = 0
var level_count: int = 1
var can_score: bool = true
#var music_progress: float = 0.0


func start_over():
	print("Starting over")
	await get_tree().create_timer(1).timeout 
	
	call_deferred("reload")

func reload():
	level_count += 1
	get_tree().reload_current_scene()
