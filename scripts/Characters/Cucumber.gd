class_name Cucumber
extends EnemyBody2D

@onready var blow_area: Area2D = $DirectionFlip/BlowHitbox
@onready var hurt_state: State = $StateMachine/Hurt

func _physics_process(delta: float) -> void:
	update_direction()
	super(delta)


func update_direction():
	if sighted_body.is_empty():
		direction.x = 0
	else:
		direction.x = move_direction


func _on_facing_timer_timeout() -> void:
	if is_dead():
		facing_timer.stop()
	else:
		move_direction *= -1


func _on_get_hit() -> void:
	lives = max(0, lives - 1)
	if is_dead():
		collision_layer = 0b10000
		collision_mask = 0b1

	state_machine.switch_state(hurt_state)


func _on_sight_area_body_entered(body: Node2D) -> void:
	sighted_body.append(body)
	facing_timer.stop()


func _on_sight_area_body_exited(body: Node2D) -> void:
	sighted_body.erase(body)

	if sighted_body.is_empty():
		facing_timer.start()
