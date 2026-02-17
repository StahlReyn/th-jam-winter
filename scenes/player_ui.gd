extends Node2D

@export var hp_bar: TextureProgressBar
@export var hp_bar_label: Label
@export var snow_bar: TextureProgressBar
@export var snow_bar_label: Label

@export var test_label: Label

var scene_battle: SceneBattle

func _ready() -> void:
	scene_battle = get_tree().current_scene

func _physics_process(delta: float) -> void:
	var player: Player = Game.get_player()
	hp_bar.value = player.hp
	hp_bar.max_value = player.mhp
	hp_bar_label.text = str(player.hp) + " / " + str(player.mhp)
	
	test_label.text = (
		"Time: " + "%.2f" % Game.game_time +
		"\nGraze: " + str(Game.graze) + 
		"\nEnemies: " + str(Game.get_alive_enemy_count()) + 
		"\nFrozen Objects: " + 
		str(Game.get_frozen_interactable_count()) + " / " +
		str(Game.get_interactable_count())
	)

func _on_coverage_timer_timeout() -> void:
	var ratio: float = Game.get_coverage_ratio()
	snow_bar.value = ratio
	snow_bar_label.text = "%.2f" % (ratio * 100) + "%"
