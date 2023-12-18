extends State

@export var ground_state: State

func on_enter():
	character.facing_timer.stop()
	animated_sprite.play("swallow")
	await get_tree().create_timer(0.15).timeout
	swallow()


func on_exit():
	super()

	if not character.sight_area.has_overlapping_bodies():
		character.direction.x = 0

func swallow():
	if character.attack_area.has_overlapping_bodies():
		for body in character.attack_area.get_overlapping_bodies():
			if body is Bomb:
				body.queue_free()
				return


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.animation == "swallow":
		await get_tree().create_timer(0.6).timeout
		next_state = ground_state
