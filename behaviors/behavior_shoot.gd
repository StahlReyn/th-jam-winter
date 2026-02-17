class_name BehaviorShoot
extends EntityBehavior

@export var cooldown: float = 1.0
@export var bullet_speed: float = 500.0

var countdown: float = 0.0

var bullet_scene: PackedScene = preload("res://entities/bullets/bullet_small.tscn")

func _ready() -> void:
	countdown = cooldown

func _physics_process(delta: float) -> void:
	if not entity.is_active:
		return
	countdown -= delta
	
	while countdown < 0:
		var bullet = Game.spawn_bullet_enemy(bullet_scene, Color.BLUE)
		bullet.global_position = entity.global_position
		
		var player: Player = Game.get_player()
		var dir: Vector2 = bullet.global_position.direction_to(player.global_position)
		bullet.velocity = dir * bullet_speed
		countdown += cooldown
