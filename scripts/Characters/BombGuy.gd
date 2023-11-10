class_name BombGuy
extends CharacterBody2D

@export var speed: float = 240.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var hurt_state: State = $StateMachine/Hurt

const BOMB_DIRECTION: Vector2 = Vector2(0.65, -0.55) * 70

var BombScene: PackedScene = preload("res://scenes/objects/bomb.tscn")

signal get_hit

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var lives: int = 5 # DEBUG purposes
var direction: Vector2 = Vector2.ZERO
var invisible: bool = false

func _ready() -> void:
	$ChargingBar.hide()
	play_tween()


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	direction.x = Input.get_axis("move_left", "move_right")
	if direction.x != 0 && state_machine.can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_facing_animation()
	move_and_slide()

#	for i in get_slide_collision_count():
#		var slide = get_slide_collision(i)
#		var collider = slide.get_collider()
#		if collider is Bomb:
#			collider.apply_torque_impulse(direction.x * push)


func update_facing_animation():
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0


func throw_bomb(factor: float):
	var bomb: Bomb = BombScene.instantiate()
	bomb.start(position)
	get_tree().root.add_child(bomb)
	bomb.apply_central_impulse(bomb_direction() * factor)


func bomb_direction() -> Vector2:
	if animated_sprite.flip_h:
		return BOMB_DIRECTION * Vector2(-1, 1)
	else:
		return BOMB_DIRECTION


func is_dead() -> bool:
	return lives == 0


func play_tween():
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(animated_sprite, "modulate:a", 0, 0.25)
	tween.tween_property(animated_sprite, "modulate:a", 1, 0.25)
	tween.tween_property(animated_sprite, "modulate:a", 0, 0.25)
	tween.tween_property(animated_sprite, "modulate:a", 1, 0.25)
	tween.play()


func on_invisible_timer_timeout() -> void:
	invisible = false


func _on_get_hit() -> void:
	if not invisible:
		lives = max(0, lives - 1)
		state_machine.switch_state(hurt_state)
		invisible = true
		get_tree().create_timer(1.5).connect("timeout", on_invisible_timer_timeout)

