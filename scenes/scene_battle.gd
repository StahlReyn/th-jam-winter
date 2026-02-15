class_name SceneBattle
extends Node2D

@onready var game_map: GameMap = $GameMap
@onready var stage_handler: StageHandler = $StageHandler

func _ready() -> void:
	Game.set_player($Player)
	stage_handler.test_wave()

func _process(delta: float) -> void:
	pass

func spawn_bullet(scene: PackedScene) -> Bullet:
	var bullet: Bullet = scene.instantiate()
	add_child(bullet)
	return bullet

func spawn_enemy(scene: PackedScene) -> Enemy:
	var enemy: Enemy = scene.instantiate()
	add_child(enemy)
	return enemy
