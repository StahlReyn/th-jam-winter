extends Node2D

@export var hp_bar: TextureProgressBar
@export var hp_bar_label: Label
@export var snow_bar: TextureProgressBar
@export var snow_bar_label: Label

@export var test_label: Label

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var player: Player = Game.get_player()
	hp_bar.value = player.hp
	hp_bar.max_value = player.mhp
	hp_bar_label.text = str(player.hp) + " / " + str(player.mhp)
	
	test_label.text = (
		"Enemies: " + str(Game.get_alive_enemy_count()) + 
		"\nGraze: " + str(Game.graze)
	)

func _on_coverage_timer_timeout() -> void:
	var ratio: float = Game.get_coverage_ratio()
	snow_bar.value = ratio
	snow_bar_label.text = "%.2f" % (ratio * 100) + "%"
