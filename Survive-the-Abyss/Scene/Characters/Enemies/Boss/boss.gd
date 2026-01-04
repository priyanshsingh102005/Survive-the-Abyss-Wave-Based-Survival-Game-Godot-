extends CharacterBody2D

@export var body:Node2D
@export var state_manager:Node
@export var projectile_scene: PackedScene
@export var projectile_point:Node2D

var is_dead:bool = false

func _ready():
	Global.boss = self

func _physics_process(delta):
	state_manager._state_transition()

func _set_dir():
	var dir = Global.player.global_position - global_position
	dir.normalized()
	return dir

func _flip():
	if abs(_set_dir().x) > 1:
		body.scale.x = sign(_set_dir().x) * 2.5

func activate_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = projectile_point.global_position
	get_tree().current_scene.add_child(projectile)
