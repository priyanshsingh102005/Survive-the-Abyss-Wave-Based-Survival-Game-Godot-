extends Node


func _on_hurt_box_health_depleated():
	get_parent().parent.is_dead = true

func _on_death_state_entered():
	get_parent().anim_player.play("Death")
	await get_parent().anim_player.animation_finished
	die()

func die():
	var wave_manager = get_tree().get_first_node_in_group("Wave_System")
	if wave_manager:
		wave_manager._on_enemy_killed()
