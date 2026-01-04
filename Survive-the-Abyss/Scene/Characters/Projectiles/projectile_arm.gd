extends CharacterBody2D

@export var body:Node2D
@export var speed:float = 600

var dir:int

func _ready():
	dir = Global.boss.body.scale.x

func _physics_process(delta):
	move_and_slide()
	$Body.scale.x = dir
	velocity.x = speed * dir
	await get_tree().create_timer(2).timeout
	queue_free()
