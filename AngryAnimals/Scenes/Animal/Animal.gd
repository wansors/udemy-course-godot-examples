extends RigidBody2D

enum AnimalState {Ready, Drag, Release}

const DRAG_LIMIT_MAX : Vector2 = Vector2(0,60)
const DRAG_LIMIT_MIN : Vector2 = Vector2(-60,0)

@onready var debug_label: Label = $DebugLabel
@onready var launch_sound: AudioStreamPlayer2D = $LaunchSound
@onready var kick_sound: AudioStreamPlayer2D = $KickSound
@onready var strech_sound: AudioStreamPlayer2D = $StrechSound
@onready var arrow: Sprite2D = $Arrow

var _state = AnimalState.Ready
var _start = position
var _dragged_vector = Vector2.ZERO
var _drag_start = Vector2.ZERO
var _arrow_scale_x: float = 0.0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()	

func setup() -> void:
	_arrow_scale_x = arrow.scale.x
	arrow.hide()
	_start= position

func debugData() -> void:
	var ds: String = "ST:%s SL:%s FR:%s\n" % [AnimalState.keys()[_state], sleeping, freeze	]
	ds += "_drag_start:%.1f, %.1f\n" % [_drag_start.x,_drag_start.y]
	ds += "_dragged_vector:%.1f, %.1f" % [_dragged_vector.x,_dragged_vector.y]
	debug_label.text=ds

func _physics_process(delta: float) -> void:
	update_state()
	debugData()	
	
func _unhandled_input(event: InputEvent) -> void:
	if _state ==AnimalState.Drag and event.is_action_released("drag") :		
		call_deferred("change_state",AnimalState.Release)# change_state(AnimalState.Release) but at the end of the frame
		
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if _state ==AnimalState.Ready and event.is_action_pressed("drag"):
		change_state(AnimalState.Drag)

func update_state() -> void:
	match _state:
		AnimalState.Drag:
			handle_dragging()

func handle_dragging() -> void:
	var new_drag_vector: Vector2 = get_global_mouse_position() - _drag_start
	_dragged_vector = new_drag_vector.clamp(DRAG_LIMIT_MIN,DRAG_LIMIT_MAX)
	var diff: Vector2 = new_drag_vector- _dragged_vector
	if diff.length() > 0 and strech_sound.playing == false:
		strech_sound.play()
	position = _start + _dragged_vector
		
#region state
func change_state(new_state: AnimalState) -> void:
	if _state != new_state:
		_state=new_state
		match _state:
			AnimalState.Drag:
				start_dragging()
			AnimalState.Release:
				start_release()
			
func start_dragging() -> void:
	arrow.show()
	_drag_start = get_global_mouse_position()
func start_release() -> void:
	arrow.show()
	launch_sound.play()
	freeze=false	
	
#endregion

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	die()	


func die() -> void:
	print("died")


func _on_sleeping_state_changed() -> void:
	pass # Replace with function body.


func _on_body_entered(body: Node) -> void:
	pass # Replace with function body.
