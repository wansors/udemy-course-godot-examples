extends Area2D

class_name Gem

signal gem_off_screen

const SPEED: float =200
static var gem_count: int =0; #Class level variable (Accesible by each instance)

func _ready() -> void:
	gem_count+=1;
	print("Generated #"+str(gem_count))
	pass
	
func _process(delta: float) -> void:
	position.y += delta * SPEED
	
	if position.y > Game.vp_r.end.y:
		print("Gem fall off")
		gem_off_screen.emit() 
		_die()


func _die() -> void:
		set_process(false)		
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	print("tocuhed by ", area)
	if area is Paddle:
		area._touchBy(self)
		_die()
