class_name EnemyHealthBar
extends TextureProgressBar

@export var enemy: Enemy

func _ready() -> void:
	modulate.a = 0.0
	var tween := create_tween()
	tween.tween_interval(1.0)
	tween.tween_property(self, "modulate", Color.WHITE, 0.5)

func _physics_process(delta: float) -> void:
	value = enemy.hp
	max_value = enemy.mhp
	min_value = 0
	
