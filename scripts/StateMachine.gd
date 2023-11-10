class_name StateMachine
extends Node

@export var character: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D
@export var current_state: State

var states: Array[State]

func _ready() -> void:
	for child in get_children():
		if child is State:
			states.append(child)
			child.character = character
			child.animated_sprite = animated_sprite
		else:
			push_warning(child.name + "isn't a State node")


func _physics_process(delta: float) -> void:
	if current_state.next_state != null:
		switch_state(current_state.next_state)

	current_state.state_process(delta)


func _input(event: InputEvent) -> void:
	current_state.state_input(event)


func can_move() -> bool:
	return current_state.can_move


func switch_state(new_state: State) -> void:
	if current_state != null:
		current_state.on_exit()

	current_state = new_state
	current_state.on_enter()

