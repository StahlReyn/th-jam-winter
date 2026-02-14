class_name Entity
extends Area2D

signal took_damage(amount: int)

var hp: int = 10
@export var mhp: int = 10

const COL_PLAYER: int = 1 << 0
const COL_ENEMY: int = 1 << 1
const COL_BULLET: int = 1 << 2

func _ready() -> void:
	hp = mhp

func _process(delta: float) -> void:
	pass

func take_damage(amount: int) -> void:
	hp -= amount
	hp = max(hp, 0)
	took_damage.emit(amount)
