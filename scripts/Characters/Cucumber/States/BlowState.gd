extends State

@export var ground_state: State

func on_enter():
	character.facing_timer.stop()
	animated_sprite.play("blow")
	await get_tree().create_timer(0.2).timeout
	blow()


func blow():
	if character.blow_area.has_overlapping_bodies():
		for body in character.blow_area.get_overlapping_bodies():
			body.is_on = false
			character.sighted_body.erase(body)


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "blow":
		await get_tree().create_timer(0.3).timeout
		next_state = ground_state
