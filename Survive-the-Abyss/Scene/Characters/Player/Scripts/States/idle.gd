extends Node


func _on_idle_state_physics_processing(delta):
	get_parent().animation_player.play("Idle" + get_parent().weapon_manager.weapon_name)
	get_parent().parent.velocity = Vector2.ZERO
