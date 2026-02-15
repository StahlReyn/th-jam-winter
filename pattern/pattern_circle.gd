class_name PatternCircle
extends PatternFactory

@export var position: Vector2
@export var rotation: float = 0.0
@export var amount: int = 16

@export var speed: float = 100
@export var acceleration: float = 0

@export var rotate_spawn: bool = true
@export var arc_angle: float = TAU
@export var offset: Vector2
@export var bullet_scene: PackedScene
@export var bullet_color: Color = Color.WHITE

func create() -> Array[Bullet]:
	spawned_bullets.clear()
	for i in range(amount):
		var bullet: Bullet = Game.spawn_bullet_enemy(bullet_scene, bullet_color)
		var angle: float = i * arc_angle/amount + rotation
		var direction := Vector2.from_angle(angle)
		bullet.position = position
		bullet.velocity = direction * speed
		bullet.acceleration = direction * acceleration
		if offset:
			bullet.position += offset.rotated(angle)
		if rotate_spawn:
			bullet.rotation = angle
		spawned_bullets.push_back(bullet)
	return spawned_bullets
