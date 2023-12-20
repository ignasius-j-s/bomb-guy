extends EnemyBody2D

@onready var pick_area: Area2D = $DirectionFlip/PickArea
@onready var hurt_state: State = $StateMachine/Hurt

func _on_get_hit() -> void:
	lives = max(0, lives - 1)
	if is_dead():
		collision_layer = 0b10000
		collision_mask = 0b1

	state_machine.switch_state(hurt_state)


func _on_facing_timer_timeout() -> void:
	if is_dead():
		facing_timer.stop()
	else:
		move_direction *= -1


func _on_sight_area_body_entered(_body: Node2D) -> void:
	facing_timer.stop()
	direction.x = move_direction


func _on_sight_area_body_exited(_body: Node2D) -> void:
	facing_timer.start()
	direction.x = 0
