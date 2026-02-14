class_name Player
extends Entity

@export var move_speed: float = 500

var pos_clamp: Vector2 = Vector2(2048, 2048)

func _ready() -> void:
	collision_layer = COL_PLAYER
	collision_mask = 0

func _process(delta: float) -> void:
	position += get_move_direction() * move_speed * delta
	position = position.clamp(-pos_clamp, pos_clamp)

func get_move_direction() -> Vector2:
	var dir: Vector2 = Vector2.ZERO
	if (Input.is_action_pressed("ui_left")):
		dir.x -= 1
	if (Input.is_action_pressed("ui_right")):
		dir.x += 1
	if (Input.is_action_pressed("ui_up")):
		dir.y -= 1
	if (Input.is_action_pressed("ui_down")):
		dir.y += 1
	return dir.normalized()
