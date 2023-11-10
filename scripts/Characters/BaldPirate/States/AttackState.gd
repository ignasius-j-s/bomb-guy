extends State

@export var ground_state: State

const KICK_DIRECTION: Vector2 = Vector2(0.75, -0.70) * 70

var kick_power: int = 40

func on_enter():
	character.facing_timer.stop()
	animated_sprite.play("attack")
	await get_tree().create_timer(0.1).timeout
	attack()


func attack():
	# include dead bomb layer
	character.attack_area.collision_layer = 0b10_10_10
	if character.attack_area.has_overlapping_bodies():
		for body in character.attack_area.get_overlapping_bodies():
			if body is BombGuy:
				body.get_hit.emit()
			elif body is Bomb:
				body.apply_central_impulse(KICK_DIRECTION * character.flip_node.scale * kick_power)

	# exclude dead bomb layer
	character.attack_area.collision_layer = 0b10_10


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "attack":
		await get_tree().create_timer(0.5).timeout
		next_state = ground_state
