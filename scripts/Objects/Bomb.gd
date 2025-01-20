class_name Bomb
extends RigidBody2D

@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var explode_area: Area2D = $ExplodeArea
@onready var timer: Timer = $Timer

var is_on: bool:
	set(new_value):
		if is_on != new_value:
			is_on = new_value
			update_bomb()
	get:
		return is_on


func _ready() -> void:
	is_on = true


func start(start_position: Vector2):
	position = start_position


func update_bomb() -> void:
	if is_on:
		animated_sprite.play("bomb_on")
		collision_layer = 0b1000
		timer.start()
	else:
		animated_sprite.play("bomb_off")
		collision_layer = 0b100000
		timer.stop()


func explode():
	rotation = 0
	freeze = true
	lock_rotation = true
	collision_shape.disabled = true
	$SFX.play(0.07)
	animated_sprite.play("bomb_explode")

	if explode_area.has_overlapping_bodies():
		for body in explode_area.get_overlapping_bodies():
			if body == self:
				continue

			if body is CharacterBody2D:
				body.get_hit.emit()
			else:
				var direction = global_position.direction_to(body.position)
				var distance = global_position.distance_to(body.position)
				if body is Bomb:
					body.apply_central_impulse(direction * 200 * (200 / distance))
					if not body.is_on:
						body.is_on = true
				elif body is Bottles:
					body.apply_central_impulse(direction * 85 * (85 / distance))


func time_left() -> float:
	return timer.time_left


func _on_timer_timeout() -> void:
	explode()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "bomb_explode":
		queue_free()
