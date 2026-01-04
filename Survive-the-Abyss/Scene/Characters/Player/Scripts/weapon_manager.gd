extends Node

signal weapon_switched(name)

enum weapons{
	SWORD,
	AXE,
	SCEPTER,
	SPECIAL
}

@export var current_weapon:weapons = weapons.SWORD

var weapon_damage:float
var prev_weapon = null
var available_weapon:String = "null"
var weapon_name:String

func _ready():
	maintaining_current_weapon()

func _process(delta):
	picking_weapon()

func changing_weapon(next):
	if current_weapon != next:
		prev_weapon = current_weapon
		current_weapon = next
		emit_signal("weapon_switched",weapon_name)
		maintaining_current_weapon()

func maintaining_current_weapon():
	match current_weapon:
		weapons.SWORD:
			weapon_name = "_Sword"
		weapons.AXE:
			weapon_name = "_Axe"
		weapons.SCEPTER:
			weapon_name = "_Scepter"
		weapons.SPECIAL:
			weapon_name = "_Special"

func picking_weapon():
	if available_weapon != "null":
		get_parent().equipped = true
		if Input.is_action_just_pressed("interact"):
			match available_weapon:
				"Axe":
					changing_weapon(weapons.AXE)
				"Scepter":
					changing_weapon(weapons.SCEPTER)
				"Special":
					changing_weapon(weapons.SPECIAL)
	else:
		if Input.is_action_just_pressed("interact") and current_weapon != weapons.SWORD:
			changing_weapon(weapons.SWORD)
			get_parent().equipped = false

func _on_weapon_detector_area_entered(area):
	available_weapon = area.Weapon_properties.weapon_name
	weapon_damage = area.Weapon_properties.damage

func _on_weapon_detector_area_exited(area):
	available_weapon = "null"
