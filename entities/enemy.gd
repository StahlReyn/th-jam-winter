class_name Enemy
extends Entity

func _ready() -> void:
	collision_layer = COL_ENEMY
	collision_mask = COL_ENEMY
	super()
	add_to_group("alive_enemy")

func _physics_process(delta: float) -> void:
	# Evil O(n^2)
	for area: Area2D in get_overlapping_areas():
		var disp: Vector2 = global_position - area.global_position
		var move_vel: Vector2 = disp.normalized() * 100
		position += move_vel * delta

func die() -> void:
	super()
	remove_from_group("alive_enemy")
