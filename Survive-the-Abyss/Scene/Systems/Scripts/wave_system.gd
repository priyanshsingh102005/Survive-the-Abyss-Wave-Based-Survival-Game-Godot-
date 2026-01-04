extends Node

signal wave_started(wave)
signal wave_completed(wave)
signal all_waves_completed()

@export var ui_kill_count:Label
@export var ui_wave_no:Label

@export var boss_spawn_pos:Node2D
@export var enemy_spawner: Node
@export var boss_scene: PackedScene
@export var total_wave: int = 3
@export var countdown_label: Label  # optional, assign a Label node in the editor

var current_wave: int = 1
var kill_count: int = 0
var goal_kill: int = 10
var wave_in_progress = false

func _ready():
	ui_wave_no.text = "Wave: " + str(current_wave)
	ui_kill_count.text = "Kills: " + str(kill_count)
	start_wave_with_countdown()

# --- MAIN LOGIC ---

func start_wave_with_countdown():
	if current_wave > total_wave:
		emit_signal("all_waves_completed")
		return

	wave_in_progress = false
	kill_count = 0
	# Start countdown coroutine
	countdown_start(3)  # countdown from 3 seconds

func countdown_start(seconds: int) -> void:
	if countdown_label:
		countdown_label.visible = true
	
	for i in range(seconds, 0, -1):
		if countdown_label:
			countdown_label.text = "     "+str(i)
		print("Wave", current_wave, "starting in:", i)
		await get_tree().create_timer(1.0).timeout

	if countdown_label:
		countdown_label.text = "START!"
	await get_tree().create_timer(0.5).timeout

	if countdown_label:
		countdown_label.visible = false

	start_wave()

func start_wave():
	print("Starting Wave:", current_wave)
	wave_in_progress = true
	emit_signal("wave_started", current_wave)
	enemy_spawner.spawn_wave(current_wave)

func _on_enemy_killed():
	if not wave_in_progress:
		return
	kill_count += 1
	ui_kill_count.text = "Kills: " + str(kill_count)
	if kill_count >= goal_kill:
		end_wave()

func end_wave():
	print("Wave", current_wave, "completed!")
	wave_in_progress = false
	emit_signal("wave_completed", current_wave)
	current_wave += 1
	ui_kill_count.text = "Kills: " + str(0)
	ui_wave_no.text = "Wave: " + str(current_wave)

	if current_wave <= total_wave:
		await get_tree().create_timer(2.0).timeout  # short delay before next countdown
		start_wave_with_countdown()
	else:
		spawn_boss()

func spawn_boss():
	$"../DrawThyBlade".fade_out()
	var boss = boss_scene.instantiate()
	boss.global_position = boss_spawn_pos.global_position
	get_tree().current_scene.add_child(boss)
	print("Boss spawned!")
	$"../DrawThyBlade".stop()
	$"../13-DecisiveBattle1-Don'tBeAfraid".play()
