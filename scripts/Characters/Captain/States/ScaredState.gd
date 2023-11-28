extends State

@export var ground_state: State
@export var run_area: Area2D

var bomb: Bomb

func on_enter():
	character.facing_timer.stop()
	bomb = run_area.get_overlapping_bodies().front()
	if bomb != null:
		set_direction()


func on_exit():
	super()
	character.direction.x = 0


func state_process(_delta: float) -> void:
	update_animation()

	if bomb == null or abs((character.position.x - bomb.position.x)) > 150 or character.sight_area.has_overlapping_bodies():
		next_state = ground_state

	if character.is_on_wall() && character.can_jump():
		jump()


func update_animation() -> void:
	if character.is_on_floor():
		animated_sprite.play("scared")


func jump() -> void:
	character.velocity.y = ground_state.jump_velocity
	animated_sprite.play("jump")


func set_direction():
	var direction = 0
	if (character.position.x - bomb.position.x) < 0:
		direction = -1
	else:
		direction = 1

	character.move_direction = direction
	character.direction.x = direction
