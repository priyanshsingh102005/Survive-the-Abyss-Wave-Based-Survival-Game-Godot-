extends Node

func _on_hurt_box_area_entered(area):
	get_parent().parent.is_hurt = true
	var damage = area.damage if Global.player.equipped == false else Global.player.weapon_manager.weapon_damage
	get_parent().hurt_box._take_damage(damage)
	
func _on_hurt_state_entered():
	get_parent().anim_player.play("Hurt")
	await get_parent().anim_player.animation_finished
	get_parent().parent.is_hurt = false
