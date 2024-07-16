extends Control

func _on_play_pressed():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_options_pressed():
	get_tree().change_scene_to_file("res://Scenes/options.tscn")

func _on_quit_pressed():
	get_tree().quit()
