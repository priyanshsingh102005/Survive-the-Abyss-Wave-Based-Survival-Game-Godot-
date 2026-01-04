extends Node

signal boss_died

@export var anim_player:AnimationPlayer
@export var hurt_box:Area2D
@export var state_chart:StateChart
@export var health_bar: ProgressBar

var parent_health:float
var phase:int = 1
var can_attack: bool = false
var charging_up:bool = false
var in_defence:bool = false

func _ready():
	health_bar._init_health(hurt_box.max_health)

func _state_transition():
	
	if hurt_box._health_percentage() < 70.0 and hurt_box._health_percentage() > 30.0:
		state_chart.send_event("phase_2")
	elif hurt_box._health_percentage() <= 30.0:
		state_chart.send_event("phase_3")

func _on_hurt_box_health_updated(health):
	parent_health = health
	health_bar._set_health(health)
	
@export var idle_timer:Timer

func _on_phase_1_state_physics_processing(delta):
	if Global.player.is_dead:
		state_chart.send_event("idle")
	else:
		if phase != 1:
			phase = 1
		if !can_attack:
			if idle_timer.is_stopped():
				idle_timer.start(randf_range(2.0,3.0))
		else:
			state_chart.send_event("attack")

func _on_phase_2_state_processing(delta):
	if Global.player.is_dead:
		state_chart.send_event("idle")
	else:
		if phase != 2:
			phase = 2
		
		if !charging_up:
			if idle_timer.is_stopped():
				idle_timer.start(randf_range(2.0,3.0))
		elif charging_up:
			return

func _on_phase_3_state_physics_processing(delta):
	if Global.player.is_dead:
		state_chart.send_event("idle")
	else:
		if phase != 3:
			phase = 3
		
		if get_parent().is_dead:
			state_chart.send_event("death")
			emit_signal("boss_died")
			return
		else:

			if !can_attack and !in_defence:
				if idle_timer.is_stopped():
					idle_timer.start(randf_range(2.0,3.0))
			else:
				state_chart.send_event("attack")

func _on_idle_time_timeout():
	match phase:
		1:
			state_chart.send_event("projectile")
		2:
			var states = ["projectile", "charge_up"]
			var chosen = states.pick_random()
			state_chart.send_event(chosen)
		3:
			var states = ["defence", "power_up"]
			var chosen = states.pick_random()
			state_chart.send_event(chosen)

func _on_attack_ranage_body_entered(body):
	can_attack = true

func _on_attack_ranage_body_exited(body):
	await anim_player.animation_finished
	can_attack = false

func _on_hurt_box_area_entered(area):
	var damage = area.damage if Global.player.equipped == false else Global.player.weapon_manager.weapon_damage
	hurt_box._take_damage(damage)
