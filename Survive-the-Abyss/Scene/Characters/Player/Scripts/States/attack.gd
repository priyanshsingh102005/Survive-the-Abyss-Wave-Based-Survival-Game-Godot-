extends Node


func _on_attack_state_entered():
	get_parent().animation_player.play("Attack" + get_parent().weapon_manager.weapon_name)
	
func _on_attack_state_physics_processing(delta):
	get_parent().parent.velocity = Vector2.ZERO
