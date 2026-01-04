extends CharacterBody2D

@export var body:Node2D
@export var state_manager:Node

@export var drop_manager:DropManager

var is_hurt:bool = false
var is_dead:bool = false
var can_attack:bool = false

func _physics_process(delta):
	state_manager.state_transition()
	move_and_slide()
	
	if is_dead:
		await get_tree().create_timer(1.5).timeout
		drop_manager.drop_random_item(global_position)
		queue_free()

func _set_dir():
	var dir = Global.player.global_position - global_position
	dir.normalized()
	return dir

func _flip():
	if abs(_set_dir().x) > 1:
		body.scale.x = sign(_set_dir().x)

func _on_attack_area_body_entered(body):
	can_attack = true
