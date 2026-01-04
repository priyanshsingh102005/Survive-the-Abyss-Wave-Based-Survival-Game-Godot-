extends Node


func _on_projectile_state_entered():
	get_parent().anim_player.play("Shoot")
	await get_parent().anim_player.animation_finished
	get_parent().state_chart.send_event("idle")
