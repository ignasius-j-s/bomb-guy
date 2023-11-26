class_name HurtState
extends State

@export var ground_state: State

func on_enter() -> void:
	if character.is_dead():
		animated_sprite.play("dead")
	else:
		animated_sprite.play("hurt")


func on_exit():
	super()
	character.play_tween()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		await get_tree().create_timer(0.1).timeout
		next_state = ground_state
	elif animated_sprite.animation == "dead":
		character.game_over.emit()

		# TODO: Do something else
		await get_tree().create_timer(0.1).timeout
		next_state = ground_state
