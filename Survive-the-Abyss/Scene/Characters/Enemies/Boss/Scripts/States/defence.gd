extends Node

@export var Defence_timer:Timer

func _on_defence_state_entered():
	get_parent().anim_player.play("Defence")
	get_parent().hurt_box.collision_mask = 0
	Defence_timer.start(2)

func _on_defence_timer_timeout():
	get_parent().anim_player.play("Defence",-1,-1,true)
	await get_parent().anim_player.animation_finished
	get_parent().state_chart.send_event("idle")
	get_parent().in_defence = false
