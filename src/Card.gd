extends KinematicBody2D

const MAX_SPEED = 2
const ACCELERATION = 10
const FRICTION = 10

var velocity = Vector2.ZERO
var card_click = false

var centerx = Vector2.ZERO
var centery = Vector2.ZERO 

var flip_final_point_bottom = Vector2.ZERO 
var flip_final_point_top = Vector2.ZERO 

var sprite_node = null

var is_on_top = false;

var isAnimationDone = false;

var animationPlayer = null

onready var bgNode = get_node("/root/Background/")

func _init():
	sprite_node = get_node("Sprite")
	pass

func _ready():
	
	animationPlayer = get_node("AnimationPlayer")
	centerx =  get_viewport_rect().size.x
	centery = get_viewport_rect().size.y
	
#	sprite_node.set_texture(fire1)
	
#	print("Centerx:", centerx)
#	print("Centery:", centery)
	
	flip_final_point_bottom = Vector2(centerx + 200, centery - 200)
	flip_final_point_top = Vector2(centerx - 350, centery - 200)
	
	is_on_top = _check_is_card_on_top()

	set_physics_process(false)
	pass


func _process(delta):
	pass

func _physics_process(delta):
	var movement_vector = move_the_card(delta)
	var x = round(self.position.x)
	var y = round(self.position.y)
#	if(is_on_top):
#		if(x == flip_final_point_top.x and y == flip_final_point_top.y):
#			isAnimationDone = true
#	else:
#		if(x == flip_final_point_bottom.x and y == flip_final_point_bottom.y):
#			isAnimationDone = true
	

func _check_is_card_on_top():
	var view_size = get_viewport().get_size()
	if(self.position.y <= 0):
		return true
	else:
		return false
	
func _on_Card_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton):
		if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
			
			if(!card_click):
				animationPlayer.play("FlipAnimation")
			
			card_click = true
			
			get_node("CollisionShape2D").disabled = true
			if(is_on_top):
				bgNode._create_top_card(false)
			else:
				bgNode._create_bottom_card(false)
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
	
	return move_and_slide(distance * MAX_SPEED)
	
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


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name.match("FlipAnimation")):
		isAnimationDone = true
		bgNode.AddNodeForMatching(self)
		bgNode.checkForMatchingNodes()
		
