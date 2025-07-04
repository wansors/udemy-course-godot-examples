extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func launcH_next_Scene() -> void:
	GameManager.navigate_to_next_scene()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
