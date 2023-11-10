extends State

@export var ground_state: State

func on_enter() -> void:
	character.facing_timer.stop()
	if character.is_dead():
		animated_sprite.play("dead")
	else:
		animated_sprite.play("hurt")


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		await get_tree().create_timer(0.3).timeout
		next_state = ground_state
	elif animated_sprite.animation == "dead":
		await get_tree().create_timer(0.3).timeout
		# never leave this state if character is dead
