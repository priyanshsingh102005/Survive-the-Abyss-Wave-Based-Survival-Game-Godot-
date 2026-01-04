extends Node

@export var right:ShapeCast2D
@export var left:ShapeCast2D

var knock_force:float = 400
var knock_duration: float = 0.1 # seconds of knockback

func _on_hurt_state_entered():
	Global.cam.screen_shake(10,0.2)
	Global._freeze(0.05, 0.2)
	get_parent().animation_player.play("Hurt")

func _on_hurt_box_area_entered(area):
	get_parent().parent.is_hurt = true
	get_parent().hurt_box._take_damage(area.damage)
	
	var dir = 0

	if right.is_colliding():
		dir = -1
	elif left.is_colliding():
		dir = 1
	
	get_parent().parent.apply_knockback(dir,knock_force,knock_duration)
