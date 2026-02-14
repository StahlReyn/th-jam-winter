class_name SceneBattle
extends Node2D

@onready var game_map: GameMap = $GameMap

func _ready() -> void:
	Game.set_player($Player)

func _process(delta: float) -> void:
	pass

func spawn_bullet(bullet_scene: PackedScene) -> Bullet:
	var bullet: Bullet = bullet_scene.instantiate()
	add_child(bullet)
	return bullet
