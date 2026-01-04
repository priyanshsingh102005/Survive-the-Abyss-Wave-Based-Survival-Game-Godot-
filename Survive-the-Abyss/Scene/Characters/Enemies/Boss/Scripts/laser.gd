@tool
extends RayCast2D

@export var growth_time :float = 0.1

var tween:Tween = null

@export var speed:float = 1000.0
@export var length:float = 1000.0
@export var color:Color = Color.WHITE:set = set_color

@export var line:Line2D
@export var hit_box_collision:CollisionShape2D
@onready var line_width := line.width

@export var is_casting:bool = false:set = set_is_casting

var points:Vector2

func _ready():
	set_color(color)
	set_is_casting(is_casting)

func _physics_process(delta):
	target_position.x = move_toward(target_position.x, length, speed * delta)
	
	var laser_end_points:= target_position
	force_raycast_update()
	if is_colliding():
		laser_end_points = to_local(get_collision_point())
	
	points = laser_end_points

func set_is_casting(new_value:bool):
	if is_casting == new_value:
		return
	is_casting = new_value
	
	set_physics_process(is_casting)
	
	if not line:
		return
	
	if is_casting == false:
		target_position = Vector2.ZERO
		_disappear()
	else:
		_appear()

func _appear():
	line.visible = true
	hit_box_collision.shape.set_deferred("length", length)
	line.points[1] = points
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line, "width", line_width, growth_time * 2.0).from(0.0)

func _disappear():
	hit_box_collision.shape.set_deferred("length", 0.01)
	if tween and tween.is_running():
		tween.kill()
	tween = create_tween()
	tween.tween_property(line, "width", 0.0, growth_time).from_current()
	tween.tween_callback(line.hide)

func set_color(new_color:Color):
	color = new_color
	if line == null:
		return
	line.modulate = new_color
