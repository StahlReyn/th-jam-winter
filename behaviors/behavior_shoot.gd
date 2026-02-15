class_name BehaviorShoot
extends EnemyBehavior

@export var cooldown: float = 0.5

var countdown: float = 0.0

var bullet_scene: PackedScene = preload("res://entities/bullets/bullet_small.tscn")

func _ready() -> void:
	countdown = cooldown

func _physics_process(delta: float) -> void:
	if enemy.is_dead:
		return
	countdown -= delta
	
	while countdown < 0:
		var bullet = Game.spawn_bullet_enemy(bullet_scene, Color.RED)
		bullet.global_position = enemy.global_position
		
		var player: Player = Game.get_player()
		var dir: Vector2 = bullet.global_position.direction_to(player.global_position)
		bullet.velocity = dir * 300
		countdown += cooldown
