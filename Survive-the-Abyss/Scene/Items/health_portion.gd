extends Area2D

@export var heal_amount: int = 25
@export var lifetime: float = 500.0
var picked_up: bool = false

func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = lifetime
	timer.one_shot = true
	timer.start()
	timer.timeout.connect(_on_timeout)

func _on_timeout():
	if not picked_up:
		queue_free()

func _on_body_entered(body):
	body.states_manager.hurt_box._heal(heal_amount)
	queue_free()
