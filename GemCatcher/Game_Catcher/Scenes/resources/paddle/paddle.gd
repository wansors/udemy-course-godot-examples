extends Area2D

class_name Paddle
const SPEED: float =500
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	var direction= Input.get_axis("move_left","move_right")		
	position.x = clampf(position.x + direction * SPEED * delta,Game.vp_r.position.x+52,get_viewport_rect().end.x-52)
	#move_and_slide()
func _touchBy(area: Area2D) -> void:
	print("call by ",area)
