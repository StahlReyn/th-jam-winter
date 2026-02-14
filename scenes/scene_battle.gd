class_name SceneBattle
extends Node2D

@onready var game_map: GameMap = $GameMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn_bullet(bullet_scene: PackedScene) -> Bullet:
	var bullet: Bullet = bullet_scene.instantiate()
	add_child(bullet)
	return bullet
