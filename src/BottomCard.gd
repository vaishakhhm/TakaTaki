extends KinematicBody2D

const MAX_SPEED = 5
const ACCELERATION = 10
const FRICTION = 10

var velocity = Vector2.ZERO
var card_click = false

var flip_final_point = Vector2(800, 350)

func _ready():
	set_physics_process(false)


func _process(delta):
	pass

func _physics_process(delta):
	move_the_card(delta)
	pass
	

func _on_Card_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
			card_click = true
			set_physics_process(true)


func _on_Card_mouse_entered():
#	print("Mouse entered the object.")
	if(!card_click):
		slide_up()


func _on_Card_mouse_exited():
#	print("Mouse left the object.")
	if(!card_click):
		slide_down()
	
func move_the_card(var delta):
	var distance
	
#	if(flip_final_point.distance_to(transform.get_origin()) > 0.05):
	distance = flip_final_point - transform.get_origin()
		#this needs to be studied as its unit vector and cause infinte sprite jiggle.
#		distance = distance.normalized() * MAX_SPEED
#	else:
#		distance = flip_final_point - transform.get_origin()
	
	move_and_slide(distance * MAX_SPEED)

func slide_up():
	var distance = Vector2(self.position.x, self.position.y - 500) - transform.get_origin()
	distance = move_and_slide(distance * MAX_SPEED)
	return

func slide_down():
	var distance = Vector2(self.position.x, self.position.y + 500) - transform.get_origin()
	move_and_slide(distance * MAX_SPEED)
	return 
