extends Node

func _on_hurt_box_health_depleated():
	get_parent().get_parent().is_dead = true

func _on_death_state_entered():
	get_parent().anim_player.play("Death")
	await get_tree().create_timer(4).timeout
	get_parent().get_parent().queue_free()
