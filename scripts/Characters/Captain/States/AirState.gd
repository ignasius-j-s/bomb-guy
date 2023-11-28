extends State

@export var ground_state: State
@export var attack_state: State

func state_process(_delta: float) -> void:
	if character.attack_area.has_overlapping_bodies():
		next_state = attack_state

	if character.is_on_floor():
		animated_sprite.play("land")
		can_move = false
		await animated_sprite.animation_finished
		next_state = ground_state


func on_enter():
	character.facing_timer.stop()
	if animated_sprite.animation != "jump":
		animated_sprite.play("float")


func on_exit():
	super()
	can_move = true
