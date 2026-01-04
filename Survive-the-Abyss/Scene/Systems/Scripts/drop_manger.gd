extends Node

class_name DropManager

@export var drops: Array[PackedScene] = []   # [Axe, Scepter, Greatsword]
@export var drop_chances: Array[float] = []  # [60, 25, 10] → total = 95%

func drop_random_item(position: Vector2) -> void:
	if drops.is_empty() or drop_chances.is_empty():
		return
	
	# Normalize and compute cumulative chances
	var total_chance: float = 0
	for chance in drop_chances:
		total_chance += chance

	var rand: float = randf() * total_chance
	var cumulative: float = 0.0

	for i in range(drops.size()):
		cumulative += drop_chances[i]
		if rand <= cumulative:
			_spawn_drop(drops[i], position)
			return
	# If no match, means nothing dropped

func _spawn_drop(scene: PackedScene, position: Vector2) -> void:
	if scene:
		var item = scene.instantiate()
		get_tree().current_scene.add_child(item)
		item.global_position = position
