class_name GameCamera
extends Camera2D

@export var follow_node: Node2D
@export var follow_speed: float = 30

var pos_clamp: Vector2 = Vector2(2048 - 1920/2, 2048 - 1080/2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = MathUtils.lerp_smooth(position, follow_node.position, follow_speed, delta)
	position = position.clamp(-pos_clamp, pos_clamp)
