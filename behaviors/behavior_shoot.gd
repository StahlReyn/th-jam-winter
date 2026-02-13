class_name BehaviorShoot
extends EnemyBehavior

@export var cooldown: float = 0.5

var countdown: float = 0.0

var bullet_scene: PackedScene = preload("res://entities/bullets/circle_bordered.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	countdown = cooldown

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	countdown -= delta
	
	while countdown < 0:
		# Should not be spawning bullets outside anyways
		var scene: SceneBattle = get_tree().current_scene
		var bullet = scene.spawn_bullet(bullet_scene)
		bullet.global_position = enemy.global_position
		
		var player: Player = Game.get_player()
		var dir: Vector2 = bullet.global_position.direction_to(player.global_position)
		bullet.velocity = dir * 300
		countdown += cooldown
