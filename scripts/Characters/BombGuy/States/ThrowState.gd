class_name ThrowState
extends State

@export var ground_state: State
@export var charging_bar: AnimatedSprite2D

func state_input(event: InputEvent) -> void:
	if event.is_action_released("throw_bomb"):
		character.throw_bomb(bar_progress())
		charging_bar.stop()
		next_state = ground_state


#func state_process(_delta: float) -> void:
#	if Input.is_action_just_released("throw_bomb"):


func on_enter() -> void:
	animated_sprite.play("idle")
	charging_bar.show()
	charging_bar.play("charging")


func on_exit() -> void:
	super()
	charging_bar.hide()


func _on_charging_bar_animation_finished() -> void:
	if charging_bar.animation == "charging":
		charging_bar.play("full")


func bar_progress() -> int:
	match charging_bar.animation:
		"charging":
			return charging_bar.frame
		"full":
			return 10
		_:
			return 0
