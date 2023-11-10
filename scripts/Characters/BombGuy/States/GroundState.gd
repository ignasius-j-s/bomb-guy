class_name GroundState
extends State

@export var air_state: State
@export var throw_state: State
@export var jump_velocity = -400.0

func state_input(event: InputEvent):
	if event.is_action_pressed("move_jump"):
		jump()
	elif event.is_action_pressed("throw_bomb"):
		next_state = throw_state


func state_process(_delta: float) -> void:
	update_animation()
	if not character.is_on_floor():
		next_state = air_state


func jump() -> void:
	character.velocity.y = jump_velocity
	next_state = air_state
	animated_sprite.play("jump")


func update_animation():
	if character.direction.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
