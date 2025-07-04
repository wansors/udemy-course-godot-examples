extends Node2D

class_name Game
const EXPLODE = preload("res://Game_Catcher/Scenes/Game/assets/explode.wav")
const GEM = preload("res://Game_Catcher/Scenes/resources/gem/gem.tscn")
const MARGIN = 70

@onready var spawn_timer: Timer = $spawnTimer
@onready var paddle: Paddle = $Paddle
@onready var music: AudioStreamPlayer = $music
@onready var score_effect: AudioStreamPlayer2D = $ScoreEffect
@onready var score_label: Label = $ScoreLabel

var score: int = 0;
static var vp_r: Rect2;


func _ready() -> void:
	print("Game start")
	updateViewport()
	get_viewport().size_changed.connect(updateViewport) # Connect to event change ratio
	_generate_random_gem()
	
func updateViewport() -> void:	
	vp_r=get_viewport_rect()
	
# delta is the time elapsed (in seconds) since the last frame
# F6 Run current scene
func _process(delta: float) -> void:
	pass


func _on_paddle_touch(area: Area2D) -> void:
	print("touch by", area)
	score+=1
	score_label.text="%03d" % score
	if score_effect.playing == false:
		score_effect.position = area.position
		score_effect.play()
	area.queue_free()
	pass # Replace with function body.


func _on_gem_gem_off_screen() -> void:
	print("game over")	
	_stop_all()


func _on_timer_timeout() -> void:
	#Generate Gem
	print("DEBUG gen time")	
	_generate_random_gem()


func _generate_random_gem() -> void:
	var new = GEM.instantiate()	
	var random_x: float = randf_range(vp_r.position.x+MARGIN, vp_r.end.x-MARGIN)
	new.position=Vector2(random_x,-50)
	# Connect to signal	
	new.gem_off_screen.connect(_on_gem_gem_off_screen)
	add_child(new)
	
func _stop_all() -> void:
	spawn_timer.stop()
	paddle.set_process(false)
	music.stop()
	music.stream=EXPLODE
	music.play()
	for child in get_children():
		if child is Gem:
			child.set_process(false)
	
	
