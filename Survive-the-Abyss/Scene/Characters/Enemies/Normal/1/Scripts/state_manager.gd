extends Node

@export var anim_player:AnimationPlayer
@export var state_chart:StateChart
@export var separation:Area2D
@export var hurt_box:Area2D

var parent

func _ready():
	parent = get_parent()

func state_transition():
	if parent.is_dead:
		parent.is_hurt = false
		parent.can_attack = false
		state_chart.send_event("death")
		parent.velocity = Vector2.ZERO
		return
	
	if Global.player.is_dead:
		anim_player.play("Idle")
		parent.velocity = Vector2.ZERO
		return

	if parent.is_hurt:
		parent.can_attack = false
		state_chart.send_event("hurt")
		parent.velocity = Vector2.ZERO
		return

	if parent.can_attack:
		state_chart.send_event("attack")
		return
	else:
		state_chart.send_event("chase")
