extends Node

@export var enemy_scenes: Array[PackedScene]
@export var spawn_points: Array[Node2D]
@export var wave_enemy_counts := [10,10,10] # number of enemies per wave

func spawn_wave(wave_number):
	var count = wave_enemy_counts[wave_number - 1]
	for i in range(count):
		spawn_enemy()

func spawn_enemy():
	if spawn_points.is_empty() or enemy_scenes.is_empty():
		return
	var spawn_point = spawn_points.pick_random()
	var enemy_scene = enemy_scenes.pick_random()
	var enemy = enemy_scene.instantiate()
	enemy.global_position = spawn_point.global_position
	add_child(enemy)
