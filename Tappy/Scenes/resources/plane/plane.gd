extends CharacterBody2D

class_name Tappy
const JUMP_POWER = -300.0
var _gravity = ProjectSettings.get("physics/2d/default_gravity")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var engine: AudioStreamPlayer2D = $Engine




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:	
		fly(delta)
		move_and_slide()
		
	
func _physics_process(delta: float) -> void:
	fly(delta)
	move_and_slide()
	if is_on_floor():
		die()

func fly(delta: float) -> void:
	velocity.y+=_gravity*delta	  
	if Input.is_action_just_pressed("jump"):
		velocity.y=JUMP_POWER
		animation_player.play("jump")
	
		
func die() -> void:
		engine.stop()
		EventBus.emit_on_play_died()
		animated_sprite_2d.stop()		
		print("DEAD")
		set_physics_process(false)
		set_process(false)
