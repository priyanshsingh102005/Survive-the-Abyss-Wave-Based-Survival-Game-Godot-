extends Node

@export var speed:float = 80.0
@export var accel:float = 40.0

func _on_chase_state_entered():
	get_parent().anim_player.play("Run")

func _on_chase_state_physics_processing(delta):
	get_parent().parent._flip()
	get_parent().parent.velocity = lerp(get_parent().parent.velocity,sign(get_parent().parent._set_dir())* speed, accel * delta)
	get_parent().parent.velocity += get_parent().separation.get_separation_vector()
