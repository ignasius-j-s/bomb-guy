class_name EnemyBody2D
extends CharacterBody2D

@export var lives: int = 2
@export var speed: float = 170.0
@export_range(0, 200) var push: int = 130

@onready var flip_node: Node2D = $DirectionFlip
@onready var animated_sprite: AnimatedSprite2D = $DirectionFlip/AnimatedSprite2D
@onready var sight_area: Area2D = $DirectionFlip/SightArea
@onready var attack_area: Area2D = $DirectionFlip/AttackHitbox
@onready var state_machine: StateMachine = $StateMachine
@onready var facing_timer: Timer = $FacingTimer

signal get_hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var sighted_body: Array[PhysicsBody2D]

# used to prevent jump right after enemy turn around
var jump_delay: float = 0

var move_direction: int = 1:
	set(new_direction):
		if new_direction != move_direction:
			move_direction = new_direction
			flip_node.scale.x = new_direction
			jump_delay = 0


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction.x != 0 && state_machine.can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	apply_torque_impulse_to_bomb()
	jump_delay = min(0.4, jump_delay + delta)


func apply_torque_impulse_to_bomb():
	for i in get_slide_collision_count():
		var slide = get_slide_collision(i)
		var collider = slide.get_collider()
		if collider is Bomb:
			collider.apply_torque_impulse(direction.x * push)


func is_dead() -> bool:
	return lives == 0


func is_running() -> bool:
	return animated_sprite.animation == "run"


func can_jump() -> bool:
	return jump_delay > 0.2 && is_on_floor()
