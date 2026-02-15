class_name Entity
extends Area2D

signal took_damage(amount: int)
signal spawned
signal died

const COL_PLAYER: int = 1 << 0
const COL_ENEMY: int = 1 << 1
const COL_BULLET: int = 1 << 2

@export var mhp: int = 10
var hp: int = 10
var is_active: bool = true
var is_dead: bool = false

func _ready() -> void:
	hp = mhp
	spawned.emit()

func take_damage(amount: int) -> void:
	hp -= amount
	hp = max(hp, 0)
	took_damage.emit(amount)
	if hp <= 0 and not is_dead:
		die()

func die() -> void:
	is_dead = true
	is_active = false
	collision_layer = 0
	died.emit()

func despawn() -> void:
	call_deferred("queue_free")
