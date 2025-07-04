extends Control
class_name GameUi

@onready var press_space_label: Label = $PressSpaceLabel
@onready var game_over_label: Label = $GameOverLabel
@onready var timer: Timer = $Timer
@onready var high_score_label: Label = $MarginContainer/highScoreLabel
@onready var game_over_sound: AudioStreamPlayer2D = $GameOverSound

var score: int =0

func exit() -> void:
	print("Exit to main menu")
	GameManager.navigate_to_main_menu()	

# Called when the node enters the scene tree for the first time.
func display_game_over() -> void:
	game_over_sound.play()
	game_over_label.show()
	press_space_label.hide()
	timer.start()
	pass # Replace with function body.

func _enter_tree() -> void:
	EventBus.tappy_is_dead.connect(display_game_over)
	EventBus.tappy_score_point.connect(increment_score)

func increment_score() -> void:
	score+=1
	high_score_label.text="%03d" % score
	pass
	
func _unhandled_input(event: InputEvent) -> void:
	if press_space_label.visible && (event.is_action_pressed("exit") || event.is_action_pressed("jump")):
		ScoreManager.high_score=score
		exit()


func _on_timer_timeout() -> void:
	game_over_label.hide()
	press_space_label.show()
