extends State

@export var air_state: State
@export var attack_state: State
@export var scared_state: State
@export var jump_velocity = -400.0

func state_process(_delta: float) -> void:
	update_animation()
	if not character.is_on_floor():
		next_state = air_state

	if character.attack_area.has_overlapping_bodies():
		next_state = attack_state

	if character.run_area.has_overlapping_bodies() and not character.sight_area.has_overlapping_bodies():
		next_state = scared_state

	if character.is_running() and character.is_on_wall():
		if character.can_jump():
			jump()


func on_enter():
	if character.facing_timer.is_stopped():
		character.facing_timer.start()


func update_animation() -> void:
	if character.direction.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")


func jump() -> void:
	character.velocity.y = jump_velocity
	next_state = air_state
	animated_sprite.play("jump")
