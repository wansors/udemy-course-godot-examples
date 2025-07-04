extends Control

@onready var highscore_value: Label = $MarginContainer/highscoreValue

# Use this functions for menus, not for real time inputs
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		GameManager.navigate_to_game()
		

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused=false
	highscore_value.text = "%03d" % ScoreManager.high_score
	pass # Replace with function body.
