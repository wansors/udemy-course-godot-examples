extends Node2D

@onready var laser: Area2D = $Laser
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound

const SPEED: float = 120.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x-=SPEED*delta
	pass


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	set_process(false)		
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if(body is Tappy):
		print("crash")
		body.die()
		
	pass # Replace with function body.


func _on_laser_body_entered(body: Node2D) -> void:
	print("point")
	score_sound.play()
	if body is Tappy:
		#Disconnect signal to avoid more notifications
		laser.body_entered.disconnect(_on_laser_body_entered)
		EventBus.emit_tappy_score_point()
