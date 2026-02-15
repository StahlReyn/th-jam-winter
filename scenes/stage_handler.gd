class_name StageHandler
extends Node

const ENEMY_FAIRY: PackedScene = preload("res://entities/enemies/fairy.tscn")
const ENEMY_FAIRY_SUNFLOWER: PackedScene = preload("res://entities/enemies/fairy_sunflower.tscn")

var scene_battle: SceneBattle

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 123456
	scene_battle = get_parent()

func _process(delta: float) -> void:
	pass

func test_wave() -> void:
	var spawn_spread = 300
	var spread = 70
	await get_tree().create_timer(3.0, false, true).timeout
	for a in range(32):
		var cluster_pos = Game.get_player().position
		cluster_pos += Vector2.from_angle(rng.randf_range(0, TAU)) * spawn_spread
		for i in range(8):
			var scene := ENEMY_FAIRY
			if i % 4 == 0:
				scene = ENEMY_FAIRY_SUNFLOWER
			var enemy: Enemy = scene_battle.spawn_enemy(scene)
			enemy.position = cluster_pos + Vector2(
				rng.randfn(0, spread), 
				rng.randfn(0, spread)
			)
			await get_tree().create_timer(0.08, false, true).timeout
		await get_tree().create_timer(8.0, false, true).timeout
