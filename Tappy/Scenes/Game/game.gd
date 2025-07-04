extends Node2D

const PIPE = preload("res://Scenes/Pipes/Pipes.tscn")


const MARGIN = 450
static var vp_r: Rect2;
@onready var upper_point: Marker2D = $UpperPoint
@onready var lower_point: Marker2D = $LowerPoint
@onready var pipe_holder: Node = $PipeHolder
@onready var spawn_timer: Timer = $SpawnTimer
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var game_ui: GameUi = $CanvasLayer/GameUi



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_pipe()
	#canvas_layer.hide()
	pass # Replace with function body.


func _enter_tree() -> void:
	EventBus.tappy_is_dead.connect(_on_plane_tappy_is_dead)



func _on_timer_timeout() -> void:
	generate_pipe()
	
func generate_pipe() -> void:	
	print("generate")
	var new = PIPE.instantiate()	
	var random_y: float = randf_range(upper_point.position.y,lower_point.position.y)
	new.position=Vector2(500,random_y)
	pipe_holder.add_child(new)
	# Initialize Pipes
	pass # Replace with function body.


func _on_plane_tappy_is_dead() -> void:
	print("tappy is dead")
	spawn_timer.stop()
	#Pause everything
	pipe_holder.get_tree().paused=true	
	canvas_layer.show()
	#exit()
	
	pass # Replace with function body.
	

	
