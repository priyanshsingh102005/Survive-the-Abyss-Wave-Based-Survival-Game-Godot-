extends Control

@export var sound_stream:AudioStreamPlayer

func _on_start_game_pressed():
	sound_stream.fade_out()
	get_tree().change_scene_to_file("res://Scene/Arenas/arena_1.tscn")

func _on_credit_pressed():
	get_tree().change_scene_to_file("res://Scene/Credits/Credits.tscn")

func _on_quit_pressed():
	get_tree().quit()
