class_name Whale
extends EnemyBody2D

func _on_facing_timer_timeout() -> void:
	if is_dead():
		facing_timer.stop()
	else:
		move_direction *= -1


func _on_sight_area_body_entered(_body: Node2D) -> void:
	facing_timer.stop()
	direction.x = move_direction


func _on_sight_area_body_exited(_body: Node2D) -> void:
	if not sight_area.has_overlapping_bodies():
		facing_timer.start()
		direction.x = 0
