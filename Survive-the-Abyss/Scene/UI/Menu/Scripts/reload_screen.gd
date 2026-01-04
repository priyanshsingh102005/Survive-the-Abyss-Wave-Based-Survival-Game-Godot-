extends Control

@export var anim_player:AnimationPlayer

var reload_screen_active:bool = false

func _process(delta):
	if Global.player.is_dead and !reload_screen_active:
		reload_screen_active = true
		anim_player.play("Lose")
	
	if !reload_screen_active:
		if Global.player != null and Global.boss != null:
			if !Global.player.is_dead and Global.boss.is_dead:
				reload_screen_active = true
				await get_tree().create_timer(2).timeout
				anim_player.play("Victory_")
		

func _on_reload_pressed():
	if $Reload.text != "Credit":
		get_tree().reload_current_scene()
	else:
		get_tree().change_scene_to_file("res://Scene/Credits/Credits.tscn")

func _on_quit_pressed():
	get_tree().quit()
