extends Node

# This class is a Global class to unify all game signals

#Signal when game over
signal tappy_is_dead

#Signal when point is scored
signal tappy_score_point


func emit_on_play_died() -> void:
	tappy_is_dead.emit()
	
func emit_tappy_score_point() -> void:
	tappy_score_point.emit()
