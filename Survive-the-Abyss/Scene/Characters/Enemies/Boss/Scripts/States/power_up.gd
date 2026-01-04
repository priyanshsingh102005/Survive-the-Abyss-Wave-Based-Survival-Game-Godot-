extends Node


func _on_power_up_state_entered():
	get_parent().anim_player.play("Power_Up")
	await get_parent().anim_player.animation_finished
	get_parent().state_chart.send_event("idle")
