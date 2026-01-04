extends CharacterBody2D

enum{
	MOVE,
	HIT
}

@export var body:Node2D
@export var anim_sprite:AnimatedSprite2D
@export var speed:float = 600

var current_state = MOVE
var dir:int

func _ready():
	dir = Global.player.body.scale.x

func _physics_process(delta):
	match current_state:
		MOVE:
			$Body/Hit_Box/CollisionShape2D.disabled = false
			anim_sprite.play("Projectile")
			body.scale.x = dir
			velocity.x = speed * dir
			move_and_slide()
		HIT:
			$Body/Hit_Box/CollisionShape2D.disabled = true
			velocity = Vector2.ZERO
			anim_sprite.play("Blast")
			await anim_sprite.animation_finished
			queue_free()

func _on_wall_detector_body_entered(body):
	current_state = HIT
