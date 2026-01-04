extends Node

@export var laser_timer:Timer
@export var laser:RayCast2D
@onready var animation_player = $"../../Body/Laser/AnimationPlayer"

func _on_laser_attack_state_entered():
	get_parent().anim_player.play("Laser_beam")
	laser.is_casting = true
	animation_player.play("rotation")
	laser_timer.start(randf_range(1.5,2.5))

func _on_laser_timer_timeout():
	laser.is_casting = false
	await get_tree().create_timer(0.5).timeout
	get_parent().charging_up = false
	get_parent().state_chart.send_event("idle")
