extends Node

func _on_death_state_entered():
	get_parent().animation_player.play("Death" + get_parent().weapon_manager.weapon_name)

func _on_death_state_physics_processing(delta):
	get_parent().parent.velocity = Vector2.ZERO

func _on_hurt_box_health_depleated():
	get_parent().parent.is_dead = true
