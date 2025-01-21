extends Control


@export var levels: Array[PackedScene]
@export var test_level_scene: PackedScene
var main_menu_scene: PackedScene = load("res://scenes/ui/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not test_level_scene:
		self.remove_child($TestButton)


func _back_to_main_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)


func _on_test_released() -> void:
	get_tree().change_scene_to_packed(test_level_scene)


func _goto_level_1() -> void:
	if levels[0]:
		get_tree().change_scene_to_packed(levels[0])
		


func _goto_level_2() -> void:
	if levels[1]:
		get_tree().change_scene_to_packed(levels[1])


func _goto_level_3() -> void:
	if levels[2]:
		get_tree().change_scene_to_packed(levels[2])


func _goto_level_4() -> void:
	if levels[3]:
		get_tree().change_scene_to_packed(levels[3])


func _goto_level_5() -> void:
	if levels[4]:
		get_tree().change_scene_to_packed(levels[4])


func _goto_level_6() -> void:
	if levels[5]:
		get_tree().change_scene_to_packed(levels[5])


func _goto_level_7() -> void:
	if levels[6]:
		get_tree().change_scene_to_packed(levels[6])
