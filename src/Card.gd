extends KinematicBody2D

const MAX_SPEED = 5
const ACCELERATION = 10
const FRICTION = 10

var velocity = Vector2.ZERO
var card_click = false

var centerx = Vector2.ZERO
var centery = Vector2.ZERO 

var flip_final_point_bottom = Vector2.ZERO 
var flip_final_point_top = Vector2.ZERO 

var is_on_top = false;

func _ready():
	centerx =  get_viewport_rect().size.x
	centery = get_viewport_rect().size.y
	
	print("Centerx:", centerx)
	print("Centery:", centery)
	
	flip_final_point_bottom = Vector2(centerx + 200, centery - 200)
	flip_final_point_top = Vector2(centerx - 350, centery - 200)
	
	is_on_top = _check_is_card_on_top()
	set_physics_process(false)
	pass


func _process(delta):
	pass

func _physics_process(delta):
	var movement_vector = move_the_card(delta)
	

func _check_is_card_on_top():
	var view_size = get_viewport().get_size()
	print(self.position)
	if(self.position.y <= 0):
		return true
	else:
		return false
	
func _on_Card_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
			card_click = true
			set_physics_process(true)
			


func _on_Card_mouse_entered():
	if(!card_click):
		slide_up()


func _on_Card_mouse_exited():
	if(!card_click):
		slide_down()
	
func move_the_card(var delta):
	var distance
	
#	if(flip_final_point.distance_to(transform.get_origin()) > 0.05):
	if(is_on_top):
		distance = flip_final_point_top - transform.get_origin()
	else:
		distance = flip_final_point_bottom - transform.get_origin()
		
		#this needs to be studied as its unit vector and cause infinte sprite jiggle.
#		distance = distance.normalized() * MAX_SPEED
#	else:
#		distance = flip_final_point - transform.get_origin()
	
	move_and_slide(distance * MAX_SPEED)
	
func slide_up():
	var distance
	if(is_on_top):
		distance = Vector2(self.position.x, self.position.y + 500) - transform.get_origin()
	else:
		distance = Vector2(self.position.x, self.position.y - 500) - transform.get_origin()
	
	distance = move_and_slide(distance * MAX_SPEED)
	return

func slide_down():
	var distance
	
	if(is_on_top):
		distance = Vector2(self.position.x, self.position.y - 500) - transform.get_origin()
	else:
		distance = Vector2(self.position.x, self.position.y + 500) - transform.get_origin()

	move_and_slide(distance * MAX_SPEED)
	return 
