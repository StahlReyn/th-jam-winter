class_name Entity
extends Area2D

signal took_damage(amount: int)
signal spawned
signal died

const COL_PLAYER: int = 1 << 0
const COL_ENEMY: int = 1 << 1
const COL_BULLET: int = 1 << 2
const COL_INTERACTABLE: int = 1 << 3

const COL_MAIN: int = COL_PLAYER | COL_ENEMY | COL_INTERACTABLE

@export var mhp: int = 10
var hp: int = 10
var is_active: bool = true
var is_dead: bool = false

@export var invincible: bool = false

@export var velocity: Vector2 = Vector2.ZERO
@export var acceleration: Vector2 = Vector2.ZERO

@export var pushable: bool = true
@export var push_force: float = 100.0
@export var mass: float = 1.0

func _ready() -> void:
	hp = mhp
	spawned.emit()

func _physics_process(delta: float) -> void:
	# Evil O(n^2)
	for area: Area2D in get_overlapping_areas():
		if area is Entity and area.pushable:
			var disp: Vector2 = area.global_position - global_position
			var move_vel: Vector2 = disp.normalized() * push_force / area.mass
			area.position += move_vel * delta
	
	velocity += acceleration * delta
	position += velocity * delta

func take_damage(amount: int) -> void:
	if invincible:
		took_damage.emit(amount)
		return
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
