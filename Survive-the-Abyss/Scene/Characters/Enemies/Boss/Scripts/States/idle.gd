extends Node

@export var speed:float = 40.0
@export var accel:float = 20.0

func _on_idle_state_entered():
	get_parent().anim_player.play("Idle")

func _on_idle_state_physics_processing(delta):
	get_parent().get_parent().move_and_slide()
	get_parent().get_parent()._flip()
	get_parent().get_parent().velocity = lerp(get_parent().get_parent().velocity,sign(get_parent().get_parent()._set_dir())* speed, accel * delta)
