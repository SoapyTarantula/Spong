extends Control

func _ready():
	$MarginContainer/VBoxContainer/MusicVolume.value = Music.music_vol
	$MarginContainer/VBoxContainer/GameVolume.value = Music.game_vol
	if Music.music_toggle:
		$MarginContainer/VBoxContainer/MusicToggle.button_pressed = true
	else:
		$MarginContainer/VBoxContainer/MusicToggle.button_pressed = false

func _process(_delta):
	$MarginContainer/VBoxContainer/MusicLabel.text = str("Music volume: " + str(Music.music_vol))
	$MarginContainer/VBoxContainer/SoundVolume.text = str("Game volume: " + str(Music.game_vol))

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")

func _on_game_volume_value_changed(value):
	Music.game_vol = value
	Music.volume_db = linear_to_db(value / 2)

func _on_music_volume_value_changed(value):
	Music.music_vol = value
	Music.volume_db = linear_to_db(value / 2)

func _on_music_toggle_toggled(toggled_on):
	if toggled_on:
		Music.music_toggle = true
		Music.play()
	else:
		Music.music_toggle = false
		Music.stop()
