extends Node
const GAME = preload("res://Scenes/Game/Game.tscn")
const MAIN_MENU = preload("res://Scenes/MainMenu/MainMenu.tscn")
const SIMPLE_TRANSITION = preload("res://Scenes/SimpleTransition/SimpleTransition.tscn")
const COMPLEX_TRANSITION = preload("res://Scenes/ComplexTransition/ComplexTransition.tscn")

var next_scene: PackedScene

func add_complex() -> void:
	var ct = COMPLEX_TRANSITION.instantiate()
	add_child(ct)

func navigate_to_game() -> void:
	next_scene = GAME
	add_complex()
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	
	
func navigate_to_main_menu() -> void:
	next_scene = MAIN_MENU
	add_complex()
	#get_tree().change_scene_to_packed(SIMPLE_TRANSITION)
	
func navigate_to_next_scene() -> void:
	get_tree().change_scene_to_packed(next_scene)
	
	
