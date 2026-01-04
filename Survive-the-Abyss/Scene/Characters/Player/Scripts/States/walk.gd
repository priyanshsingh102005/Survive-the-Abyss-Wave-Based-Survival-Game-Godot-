extends Node

@export var speed:float = 120.0
@export var accel:float = 80.0

func _on_walk_state_physics_processing(delta):
	get_parent().parent._flip_face()
	get_parent().animation_player.play("Walk" + get_parent().weapon_manager.weapon_name, -1,0.6)
	get_parent().parent.velocity.x = lerp(get_parent().parent.velocity.x, speed * get_parent().parent.set_dir().x, accel * delta)
	get_parent().parent.velocity.y = lerp(get_parent().parent.velocity.y, speed * get_parent().parent.set_dir().y, accel * delta)
