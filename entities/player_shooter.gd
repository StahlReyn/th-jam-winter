class_name PlayerShooter
extends Node

@export var player: Player
@export var player_movement: PlayerMovement
@export var shoot_arrow: Node2D
@export var shoot_cooldown: float = 0.2

var bullet_scene: PackedScene = preload("res://entities/bullets/bullet_ice.tscn")
var shoot_countdown: float = shoot_cooldown
var shoot_angle: float = 0.0

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	shoot_countdown -= delta
	
	shoot_arrow.rotation = MathUtils.lerp_angle_smooth(
		shoot_arrow.rotation, player_movement.velocity.angle(), 20, delta
	)
	
	if Input.is_action_pressed("shoot"):
		shoot_arrow.modulate.a = MathUtils.lerp_smooth(
			shoot_arrow.modulate.a, 1.0, 20, delta
		)
		if shoot_countdown <= 0:
			var shoot_amount = 3
			var bullet_speed = 800
			for i in range(shoot_amount):
				var bullet = Game.spawn_bullet_player(bullet_scene, Color.AQUA)
				bullet.global_position = player.global_position
				
				var angle: float = shoot_arrow.rotation
				@warning_ignore("integer_division")
				angle += (i - shoot_amount/2) * 0.25
				bullet.rotation = angle
				bullet.velocity = Vector2.from_angle(angle) * bullet_speed
			shoot_countdown = shoot_cooldown
	else:
		shoot_arrow.modulate.a = MathUtils.lerp_smooth(
			shoot_arrow.modulate.a, 0.0, 20, delta
		)
