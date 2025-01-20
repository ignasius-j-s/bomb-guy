class_name AirState
extends State

@export var ground_state: State
var can_drop_bomb: bool

var sfx_player = AudioStreamPlayer.new()
var step_sfx_stream = preload("res://assets/Audio/Step.wav")

func _ready():
	sfx_player.stream = step_sfx_stream
	get_tree().root.add_child.call_deferred(sfx_player)


func state_process(_delta: float) -> void:
	if character.is_on_floor():
		animated_sprite.play("land")
		can_move = false
		await animated_sprite.animation_finished
		next_state = ground_state


func state_input(event: InputEvent):
	if event.is_action_pressed("throw_bomb") && can_drop_bomb:
		character.throw_bomb(0)
		can_drop_bomb = false


func on_enter() -> void:
	if animated_sprite.animation != "jump":
		animated_sprite.play("float")
		can_drop_bomb = false
	else:
		can_drop_bomb = true


func on_exit() -> void:
	if next_state == ground_state:
		sfx_player.play()
		
	super()
	can_move = true
