class_name StageHandler
extends Node

const ENEMY_FAIRY: PackedScene = preload("res://entities/enemies/fairy.tscn")
const ENEMY_FAIRY_DANDELION: PackedScene = preload("res://entities/enemies/fairy_dandelion.tscn")
const ENEMY_FAIRY_SUNFLOWER: PackedScene = preload("res://entities/enemies/fairy_sunflower.tscn")

var scene_battle: SceneBattle

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.seed = 123456
	scene_battle = get_parent()

func _physics_process(delta: float) -> void:
	pass

func spawn_cluster(scene: PackedScene, position: Vector2, spread: float, amount: int, interval: float):
	for i in range(amount):
		var enemy: Enemy = scene_battle.spawn_enemy(scene)
		enemy.position = position + Vector2(
			rng.randfn(0, spread), 
			rng.randfn(0, spread)
		)
		await create_tween().tween_interval(interval).finished

func random_pos_from_player(distance: float) -> Vector2:
	return (
		Game.get_player().position + 
		Vector2.from_angle(rng.randf_range(0, TAU)) * distance
	)

func test_wave() -> void:
	await create_tween().tween_interval(3.0).finished
	wave_1()

# PLACEHOLDER PLACE TO MAKE WAVES
func wave_1() -> void:
	while Game.coverage_ratio < 0.10:
		var cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 2, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 100, 3, 0.1)
		await create_tween().tween_interval(7.0).finished
	while Game.coverage_ratio < 0.20:
		var cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 90, 5, 0.1)
		await create_tween().tween_interval(7.0).finished
	while Game.coverage_ratio < 0.40:
		var cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 2, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 8, 0.08)
		await create_tween().tween_interval(7.0).finished
	while Game.coverage_ratio < 0.60:
		var cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 1, 0.50)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 4, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 8, 0.08)
		await create_tween().tween_interval(7.0).finished
	while Game.coverage_ratio < 0.90:
		var cluster_pos = random_pos_from_player(400)
		spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 2, 0.20)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 5, 0.2)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 5, 0.08)
		await create_tween().tween_interval(7.0).finished
