extends Node


func _on_attack_state_entered():
	get_parent().anim_player.play("Attack")
	await get_parent().anim_player.animation_finished
	get_parent().parent.can_attack = false


func _on_attack_state_processing(delta):
	get_parent().parent.velocity = Vector2.ZERO
