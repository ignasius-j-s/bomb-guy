class_name State
extends Node

@export var can_move: bool = true

var character: CharacterBody2D
var animated_sprite: AnimatedSprite2D
var next_state: State

func state_process(_delta: float) -> void:
	pass


func state_input(_event: InputEvent) -> void:
	pass


func on_enter() -> void:
	pass


func on_exit() -> void:
	next_state = null

