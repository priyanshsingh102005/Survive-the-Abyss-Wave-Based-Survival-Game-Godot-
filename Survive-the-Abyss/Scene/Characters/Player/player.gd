extends CharacterBody2D

@export var states_manager:Node
@export var weapon_manager:Node
@export var body:Node2D
@export var projectile_scene: PackedScene
@export var projectile_point:Node2D

var input_vector:Vector2 = Vector2.ZERO
var is_hurt:bool = false
var is_dead:bool = false
var can_attack:bool = true
var equipped:bool = false

var knockback: Vector2 = Vector2.ZERO

func _ready():
	Global.player = self

func _physics_process(delta):
	states_manager._state_transition()
	move_and_slide()

func _flip_face():
	if set_dir().x != 0 and can_attack:
		body.scale.x = set_dir().x

func set_dir():
	input_vector = Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left"), Input.get_action_strength("Down") - Input.get_action_strength("Up"))
	input_vector.normalized()
	return input_vector

func activate_projectile():
	var projectile = projectile_scene.instantiate()
	projectile.global_position = projectile_point.global_position
	get_tree().current_scene.add_child(projectile)

func apply_knockback(dir: int, force: float, duration: float):
	is_hurt = true
	knockback = Vector2(dir * force,0)
	var t = get_tree().create_timer(duration)
	t.timeout.connect(_end_knockback)

func _end_knockback():
	is_hurt = false
	knockback = Vector2.ZERO

func _reset_attack():
	can_attack = true
