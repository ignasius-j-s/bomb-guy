extends State

@export var ground_state: State
@export var joint: Node2D

const THROW_DIRECTION: Vector2 = Vector2(0.85, -0.40) * 75

var throw_power: int = 45
var process = false
var bomb: Bomb
var bomb_collision_layer = 0b1000
var bomb_collision_mask = 0b101011

func state_process(_delta: float):
	if process:
		update_animation()
		if bomb.freeze:
			bomb.global_position = joint.global_position

		if bomb.time_left() < 0.75:
			can_move = false
			throw()

		if character.sight_area.has_overlapping_bodies():
			var player: BombGuy = character.sight_area.get_overlapping_bodies().front()
			if abs(character.position.x - player.position.x) < 285:
				can_move = false
				throw()


func on_enter():
	character.facing_timer.stop()
	can_move = false
	animated_sprite.play("bomb_pick")
	bomb = character.pick_area.get_overlapping_bodies().front()
	bomb.freeze = true
	bomb.collision_layer = 0
	bomb.collision_mask = 0


func on_exit():
	super()
	can_move = true


func update_animation() -> void:
	if character.direction.x != 0:
		animated_sprite.play("bomb_run")
	else:
		animated_sprite.play("bomb_idle")


func throw():
	animated_sprite.play("bomb_throw")
	process = false
	bomb.freeze = false
	bomb.apply_central_impulse(THROW_DIRECTION * character.flip_node.scale * throw_power)
	bomb.collision_mask = bomb_collision_mask


func _on_animated_sprite_2d_animation_finished():
	match animated_sprite.animation:
		"bomb_pick":
			can_move = true
			process = true
		"bomb_throw":
			bomb.collision_layer = bomb_collision_layer
			await get_tree().create_timer(0.45).timeout
			next_state = ground_state


func _on_big_guy_get_hit():
	process = false
	can_move = false

	if character.state_machine.current_state == self:
		bomb.explode()
