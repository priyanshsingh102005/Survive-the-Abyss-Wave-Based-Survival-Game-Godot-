extends Node

func _on_melee_attack_state_entered():
	get_parent().anim_player.play("Melee_Attack")
	await get_parent().anim_player.animation_finished
	get_parent().state_chart.send_event("idle")
