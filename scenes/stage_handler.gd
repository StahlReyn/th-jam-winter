class_name StageHandler
extends Node

const ENEMY_FAIRY: PackedScene = preload("res://entities/enemies/fairy.tscn")
const ENEMY_FAIRY_DANDELION: PackedScene = preload("res://entities/enemies/fairy_dandelion.tscn")
const ENEMY_FAIRY_ROSE: PackedScene = preload("res://entities/enemies/fairy_rose.tscn")
const ENEMY_FAIRY_SUNFLOWER: PackedScene = preload("res://entities/enemies/fairy_sunflower.tscn")
const ENEMY_LILY_WHITE: PackedScene = preload("res://entities/enemies/lily_white.tscn")

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
	var cluster_pos: Vector2
	#Game.coverage_ratio = 0.9
	#Game.power = 400
	while Game.coverage_ratio < 0.05:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 100, 3, 0.2)
		await create_tween().tween_interval(10.0).finished
	while Game.coverage_ratio < 0.15:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 90, 5, 0.2)
		await create_tween().tween_interval(10.0).finished
	while Game.coverage_ratio < 0.25:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 1, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 4, 0.1)
		await create_tween().tween_interval(12.0).finished
	while Game.coverage_ratio < 0.40:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_ROSE, cluster_pos, 70, 1, 0.25)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 2, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 3, 0.1)
		await create_tween().tween_interval(14.0).finished
	while Game.coverage_ratio < 0.55:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 1, 0.50)
		spawn_cluster(ENEMY_FAIRY_ROSE, cluster_pos, 70, 1, 0.25)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 1, 0.25)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 3, 0.08)
		await create_tween().tween_interval(18.0).finished
	while Game.coverage_ratio < 0.70:
		# Also delay at start to prevent 2 sandwiched
		await create_tween().tween_interval(5.0).finished
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 2, 1.50)
		spawn_cluster(ENEMY_FAIRY_ROSE, cluster_pos, 70, 2, 0.50)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 2, 0.50)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 2, 0.08)
		await create_tween().tween_interval(20.0).finished
	# Calm Buffer
	while Game.coverage_ratio < 0.80:
		await create_tween().tween_interval(1.0).finished
	# Lily Wave here
	scene_battle.start_wave()
	await create_tween().tween_interval(2.0).finished
	cluster_pos = random_pos_from_player(500)
	spawn_cluster(ENEMY_LILY_WHITE, cluster_pos, 0, 1, 0.2)
	spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 2, 1.50)
	spawn_cluster(ENEMY_FAIRY_ROSE, cluster_pos, 70, 3, 0.3)
	await create_tween().tween_interval(20.0).finished
	while Game.coverage_ratio < 0.95:
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_DANDELION, cluster_pos, 70, 3, 0.50)
		spawn_cluster(ENEMY_FAIRY, cluster_pos, 70, 2, 0.08)
		await create_tween().tween_interval(15.0).finished
		cluster_pos = random_pos_from_player(500)
		spawn_cluster(ENEMY_FAIRY_SUNFLOWER, cluster_pos, 70, 1, 1.50)
		spawn_cluster(ENEMY_FAIRY_ROSE, cluster_pos, 70, 2, 0.50)
		await create_tween().tween_interval(15.0).finished
