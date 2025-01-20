extends Control

@export var test_level_scene: PackedScene
var main_menu_scene: PackedScene = load("res://scenes/ui/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not test_level_scene:
		self.remove_child($TestButton)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _back_to_main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_test_released() -> void:
	get_tree().change_scene_to_packed(test_level_scene)
