class_name GameCamera
extends Camera2D

@export var follow_node: Node2D
@export var follow_speed: float = 30

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = MathUtils.lerp_smooth(position, follow_node.position, follow_speed, delta)
