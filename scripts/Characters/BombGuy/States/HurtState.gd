class_name HurtState
extends State

@export var ground_state: State

var sfx_player = AudioStreamPlayer.new()
var hurt_sfx_stream = preload("res://assets/Audio/Hurt.ogg")

func _ready():
	sfx_player.stream = hurt_sfx_stream
	get_tree().root.add_child.call_deferred(sfx_player)

func on_enter() -> void:
	sfx_player.play()
	if character.is_dead():
		animated_sprite.play("dead")
	else:
		animated_sprite.play("hurt")


func on_exit():
	super()
	character.play_tween()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "hurt":
		await get_tree().create_timer(0.1).timeout
		next_state = ground_state
	elif animated_sprite.animation == "dead":
		await get_tree().create_timer(0.1).timeout
		character.game_over.emit()
