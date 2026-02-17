class_name PatternFlower
extends PatternFactory

@export var position: Vector2
@export var petal_count: int = 6
@export var petal_size: int = 5
@export var speed_min: float = 100.0
@export var speed_max: float = 100.0
@export var rotation: float = 0.0
@export var arc_angle: float = TAU

@export var bullet_scene: PackedScene
@export var bullet_color: Color = Color.WHITE

func create() -> Array[Bullet]:
	spawned_bullets.clear()
	var angle_per_petal = arc_angle / petal_count
	for i in range(petal_count):
		petal(i * angle_per_petal + rotation)
	
	return spawned_bullets

func petal(main_angle: float):
	var angle_per_petal = arc_angle / petal_count
	var angle_per_bullet = angle_per_petal * 0.5 / petal_size
	var bullet: Bullet
	for j in range(petal_size):
		for k in range(2):
			bullet = Game.spawn_bullet_enemy(bullet_scene, bullet_color)
			bullet.global_position = position
			var bullet_angle = main_angle
			if k == 1:
				bullet_angle += j * angle_per_bullet
			else:
				bullet_angle -= j * angle_per_bullet
			var direction := Vector2.from_angle(bullet_angle)
			var speed = speed_min + (speed_max - speed_min) * (1 - float(j)/petal_size)
			
			bullet.velocity = direction * speed
			bullet.rotation = bullet_angle
			spawned_bullets.push_back(bullet)
