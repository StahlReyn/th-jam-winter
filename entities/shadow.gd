extends Sprite2D

@export var main_sprite: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	scale.x = max((70 + main_sprite.position.y) / 70, 0)
