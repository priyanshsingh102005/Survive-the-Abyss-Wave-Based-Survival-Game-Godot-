extends Node

@export var charge_up_timer:Timer

func _on_charge_up_state_entered():
	get_parent().anim_player.play("Charge_Up")
	get_parent().charging_up = true
	charge_up_timer.start(randf_range(3.0,3.5))

func _on_charge_up_timeout():
	get_parent().state_chart.send_event("attack")
