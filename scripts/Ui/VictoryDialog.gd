extends Control

@onready var button_container: Node = $VBoxContainer/HBoxContainer
@onready var next_button: Node = $VBoxContainer/HBoxContainer/NextButton
@export var next_scene: PackedScene
var main_menu_scene: PackedScene = load("res://scenes/ui/main_menu.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.hide()
	if not next_scene:
		button_container.remove_child(next_button)


func _on_victory():
	get_tree().paused = true
	self.show()
	

func _on_next_released():
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_scene)


func _on_restart_released():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_released():
	get_tree().paused = false
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_bomb_guy_victory() -> void:
	pass # Replace with function body.
