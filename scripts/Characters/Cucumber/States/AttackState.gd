extends State

@export var ground_state: State

func on_enter():
	character.facing_timer.stop()
	animated_sprite.play("attack")
	await get_tree().create_timer(0.2).timeout
	attack()


func attack():
	if character.attack_area.has_overlapping_bodies():
		for body in character.attack_area.get_overlapping_bodies():
			body.get_hit.emit()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		await get_tree().create_timer(0.5).timeout
		next_state = ground_state
