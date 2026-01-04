extends Area2D

@export var separation_force: float = 25.0
var owner_enemy: CharacterBody2D
var nearby_enemies: Array = []

func _ready():
	owner_enemy = get_parent()

func _on_overlap_body_entered(body):
	if body.is_in_group("enemy") and body != owner_enemy:
		nearby_enemies.append(body)

func _on_overlap_body_exited(body):
	if body.is_in_group("enemy") and body != owner_enemy:
		nearby_enemies.erase(body)

func get_separation_vector() -> Vector2:
	var repel_vec = Vector2.ZERO
	for enemy in nearby_enemies:
		var away = (owner_enemy.global_position - enemy.global_position)
		var dist = away.length()
		if dist > 0:
			repel_vec += away.normalized() / dist  # closer = stronger push
	return repel_vec.normalized() * separation_force if repel_vec != Vector2.ZERO else Vector2.ZERO
