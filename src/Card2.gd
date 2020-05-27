extends Node2D

var velocity = Vector2.ZERO

const SPEED = 500

var flip_final_point_bottom = Vector2.ZERO 
var flip_final_point_top = Vector2.ZERO 
var is_card_on_top

var animationPlayer = null
var centerx
var centery
var card_click = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	animationPlayer = get_node("AnimationPlayer")
	centerx =  get_viewport_rect().size.x
	centery = get_viewport_rect().size.y
	
	print("Centerx:", centerx)
	print("Centery:", centery)
	
	flip_final_point_bottom = Vector2(centerx + 200, centery - 200)
	flip_final_point_top = Vector2(centerx - 350, centery - 200)
	
	print("Final Point top: ", flip_final_point_top)
	print("Final Point bottom: ", flip_final_point_bottom)

	
	is_card_on_top = _check_is_card_on_top()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _physics_process(delta):
	if Input.is_mouse_button_pressed(1):
		move_the_card(delta)
		if(!card_click):
			animationPlayer.play("FlipAnimation")
		
		card_click = true
#		var bgNode = get_node("/root/Background/")
#		if(!is_card_on_top):
#			bgNode._create_bottom_card()
#		else:
#			bgNode._create_top_card()
			
	pass

func _check_is_card_on_top():
	var view_size = get_viewport().get_size()
	if(self.position.y <= 0):
		print("Top Card Position: ", self.position)
		return true
	else:
		print("Bottom Card Position: ", self.position)
		return false

func move_the_card(var delta):
	var distance

	if(is_card_on_top):
		var angle = get_angle_to(flip_final_point_top)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		
		position += velocity * SPEED * delta
		#distance = flip_final_point_top - transform.get_origin()
	else:
		var angle = get_angle_to(flip_final_point_bottom)
		velocity.x = cos(angle)
		velocity.y = sin(angle)
		
		position += velocity * SPEED * delta
		print("Moving Pos: ", position)
		#distance = flip_final_point_bottom - transform.get_origin()
	
	#move_and_slide(distance * MAX_SPEED)
