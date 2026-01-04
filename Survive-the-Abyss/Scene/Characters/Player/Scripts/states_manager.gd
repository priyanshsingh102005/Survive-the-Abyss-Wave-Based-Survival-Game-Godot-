extends Node

@export var animation_player:AnimationPlayer
@export var state_chart:StateChart
@export var weapon_manager:Node
@export var hurt_box:Area2D
@export var health_bar:ProgressBar

var parent

func _ready():
	parent = get_parent()
	health_bar._init_health(hurt_box.health)

func _state_transition():
	if parent.is_dead == true:
		parent.is_hurt = false
		parent.can_attack = true
		state_chart.send_event("dead")
		return
	
	if parent.is_hurt == true:
		parent.velocity = parent.knockback
		parent.can_attack = true
		state_chart.send_event("hurt")
		return
	
	if animation_player.current_animation != "Attack" + weapon_manager.weapon_name and animation_player.is_playing():
		if Input.is_action_just_pressed("Attack") and parent.can_attack:
			parent.can_attack = false
			state_chart.send_event("attack")
			return

	if parent.can_attack:
		if parent.set_dir() == Vector2.ZERO:
			state_chart.send_event("idle")
		else:
			state_chart.send_event("walk")

func _on_hurt_box_health_updated(health):
	health_bar._set_health(health)
