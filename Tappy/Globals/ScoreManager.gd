extends Node

const SCORE_PATH: String = "user://tappy.tres"

var _high_score:int =0;
#Getter and setter
var high_score: int:
	get:
		return _high_score
	set(value):
		if(value > _high_score):
			_high_score=value
			save_high_score()

func _ready() -> void:
	load_high_score()	

func load_high_score() -> void:	
	if ResourceLoader.exists(SCORE_PATH):
		var hsr: HighScoreResource = load(SCORE_PATH)
		if hsr:
			high_score=hsr._high_score
		
	
# Save resource file
func save_high_score() -> void:
	var hsr: HighScoreResource = HighScoreResource.new()
	hsr._high_score=high_score
	ResourceSaver.save(hsr,SCORE_PATH)
