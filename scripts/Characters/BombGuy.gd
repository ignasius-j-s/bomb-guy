class_name BombGuy
extends CharacterBody2D

@export var speed: float = 240.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine
@onready var hurt_state: State = $StateMachine/Hurt

const BOMB_DIRECTION: Vector2 = Vector2(0.65, -0.55) * 70

var BombScene: PackedScene = preload("res://scenes/objects/bomb.tscn")
var RunParticleScene: PackedScene = preload("res://scenes/particles/run_particle.tscn")

signal get_hit
signal get_extra_live
signal game_over

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var lives: int = 3
var direction: Vector2 = Vector2.ZERO
var invisible: bool = false
var run_particle_delay = 0

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

	run_particle(delta)

	update_facing_animation()
	move_and_slide()


func run_particle(delta):
	if is_running() and run_particle_delay <= 0:
		var shift_x = -4
		var particle: Particles = RunParticleScene.instantiate()
		particle.position = position

		if animated_sprite.flip_h:
			particle.scale.x *= -1
			shift_x *= -1

		particle.position.x += shift_x
		get_tree().root.add_child(particle)
		run_particle_delay = 0.45
	else:
		run_particle_delay = max(0, run_particle_delay - delta)


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


func is_running() -> bool:
	return animated_sprite.animation == "run"


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



func _on_get_extra_live() -> void:
	lives = min(3, lives + 1)
