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
	if player.is_dead:
		return
	shoot_countdown -= delta
	
	shoot_arrow.rotation = MathUtils.lerp_angle_smooth(
		shoot_arrow.rotation, player.aim_angle, 20, delta
	)
	
	if Input.is_action_pressed("shoot"):
		shoot_arrow.modulate.a = MathUtils.lerp_smooth(
			shoot_arrow.modulate.a, 1.0, 20, delta
		)
		if shoot_countdown <= 0:
			shoot_countdown = shoot_cooldown
			@warning_ignore("integer_division")
			var shoot_amount: int = 5 + Game.power / 100
			var bullet_speed: float = 1000
			var spread: float = 0.1 + 1.0 / shoot_amount
			var color: Color = Color.AQUA
			if Input.is_action_pressed("focus"):
				shoot_amount -= 2
				spread *= 0.25
				bullet_speed *= 1.5
				shoot_countdown *= 0.5
				color = Color.BLUE
			for i in range(shoot_amount):
				var bullet = Game.spawn_bullet_player(bullet_scene, color)
				bullet.global_position = player.global_position
				
				var angle: float = shoot_arrow.rotation
				@warning_ignore("integer_division")
				angle += (i + 0.5 - shoot_amount * 0.5) * spread
				bullet.rotation = angle
				bullet.velocity = Vector2.from_angle(angle) * bullet_speed
			AudioManager.play_shoot1()
	else:
		shoot_arrow.modulate.a = MathUtils.lerp_smooth(
			shoot_arrow.modulate.a, 0.0, 20, delta
		)
