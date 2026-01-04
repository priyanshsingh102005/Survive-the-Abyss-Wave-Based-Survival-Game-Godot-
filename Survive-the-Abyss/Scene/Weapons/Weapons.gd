extends Area2D

@export var Weapon_properties:WeaponData

func _ready():
	await get_tree().create_timer(5).timeout
	queue_free()
