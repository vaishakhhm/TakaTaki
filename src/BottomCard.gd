extends KinematicBody2D

const MAX_SPEED = 9000
const ACCELERATION = 10000
const FRICTION = 10000

var velocity = Vector2.ZERO
var card_click = false

func _ready():
	set_physics_process(false)
	pass


func _process(delta):
	pass

func _physics_process(delta):
	var movement_vector = move_the_card(delta)
	

func _on_Card_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
			print("Got Click event.")
			set_physics_process(true)


func _on_Card_mouse_entered():
	print("Mouse entered the object.")


func _on_Card_mouse_exited():
	print("Mouse left the object.")
	
func move_the_card(var delta):
	var distance = Vector2(800, 350) - position
	velocity = distance
	
	velocity = velocity.normalized()
	velocity = velocity.move_toward(velocity * MAX_SPEED, ACCELERATION * delta)	
	velocity = move_and_slide(velocity)
	
	return velocity
