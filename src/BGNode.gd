extends Node2D

var _new_card = null

var topPlayerCards = null
var bottomPlayerCards = null

var total_top_cards = 4
var total_bottom_cards = 4

var old_total_top_cards = total_top_cards
var old_total_bottom_cards = total_bottom_cards

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().get_root().connect("size_changed", self, "myfunc")
	
	topPlayerCards = $Area2D/TopPlayerCards
	bottomPlayerCards = $Area2D/BottomPlayerCards
	
	topPlayerCards.text = "Cards left: " + String(total_top_cards)
	bottomPlayerCards.text = "Cards left: " + String(total_bottom_cards)
	
	print("Window size:", OS.get_real_window_size())
	print("Viewport size:", get_viewport().get_size())
	print("ViewportRect size:", get_viewport_rect().size)
		
	var has_created = false;
	
	has_created = _create_top_card(true)
	has_created = _create_bottom_card(true)
	
	if(!has_created):
		print("Failed to create top/bottom cards")


#func myfunc():
#	print("Resizing: ", get_viewport_rect().size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if total_top_cards != old_total_top_cards:
		topPlayerCards.text = "Cards left: " + String(total_top_cards)
		old_total_top_cards = total_top_cards
		
	if total_bottom_cards != old_total_bottom_cards:
		bottomPlayerCards.text = "Cards left: " + String(total_bottom_cards)
		old_total_bottom_cards = total_bottom_cards
		
	pass

func TestMethod():
	print("This is a test method.")
	pass

func _create_bottom_card(var initialCard):
	if(total_bottom_cards > 1):
		_new_card = preload("res://Scenes/Card.tscn").instance()
		var pos = Vector2(1950,1120)
		_new_card.set_position(pos)
		get_node("Area2D/Sprite").add_child(_new_card)
	if (!initialCard):
		total_bottom_cards -= 1
		return true
	else:
		return false

func _create_top_card(var initialCard):
	if(total_top_cards > 1):
		_new_card = preload("res://Scenes/Card.tscn").instance()
		var pos = Vector2(425,-30)
		_new_card.set_position(pos)
		get_node("Area2D/Sprite").add_child(_new_card)
	if (!initialCard):
		total_top_cards -= 1
		return true
	else:
		return false
