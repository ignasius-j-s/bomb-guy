class_name GroundState
extends State

@export var air_state: State
@export var throw_state: State
@export var jump_velocity = -400.0

var sfx_player = AudioStreamPlayer.new()
var jump_sfx_stream = preload("res://assets/Audio/Jump.wav")

func _ready():
	sfx_player.stream = jump_sfx_stream
	sfx_player.volume_db = 7.0
	get_tree().root.add_child.call_deferred(sfx_player)


func state_input(event: InputEvent):
	if event.is_action_pressed("move_jump"):
		jump()
	elif event.is_action_pressed("throw_bomb") and animated_sprite.animation != "door_in":
		next_state = throw_state


func state_process(_delta: float) -> void:
	update_animation()
	if not character.is_on_floor():
		next_state = air_state


func jump() -> void:
	character.velocity.y = jump_velocity
	next_state = air_state
	sfx_player.play()
	animated_sprite.play("jump")


func update_animation():
	if animated_sprite.animation == "door_in":
		self.can_move = false
		return
	
	if character.direction.x != 0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
