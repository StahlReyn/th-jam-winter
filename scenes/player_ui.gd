extends Node2D

@onready var hp_bar: ProgressBar = $Bars/CenterContainer/HpBar
@onready var hp_bar_label: Label  = $Bars/CenterContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var player: Player = Game.get_player()
	hp_bar.value = player.hp
	hp_bar.max_value = player.mhp
	hp_bar_label.text = str(player.hp) + " / " + str(player.mhp)
	
