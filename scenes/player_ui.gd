extends Node2D

@export var snow_bar: TextureProgressBar
@export var snow_bar_label: Label
@export var hp_bar: TextureProgressBar
@export var hp_bar_label: Label
@export var power_bar: TextureProgressBar
@export var power_bar_label: Label

@export var stat_label: Label

var scene_battle: SceneBattle

func _ready() -> void:
	scene_battle = get_tree().current_scene

func _physics_process(_delta: float) -> void:
	var player: Player = Game.get_player()
	hp_bar.value = player.hp
	hp_bar.max_value = player.mhp
	hp_bar_label.text = str(player.hp) + " / " + str(player.mhp)
	
	var ratio: float = Game.coverage_ratio
	snow_bar.value = ratio
	snow_bar_label.text = "%.2f" % (ratio * 100) + "%"
	
	power_bar.value = Game.power
	power_bar.max_value = Game.max_power
	power_bar_label.text = str(Game.power) + " / " + str(Game.max_power)
	
	stat_label.text = (
		"Time: " + "%.2f" % Game.game_time +
		"\nGraze: " + str(Game.graze) + 
		"\nEnemies: " + str(Game.get_alive_enemy_count())
	)
