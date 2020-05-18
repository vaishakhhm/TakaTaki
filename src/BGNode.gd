extends Node2D

var _new_card = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().get_root().connect("size_changed", self, "myfunc")
	
	print("Window size:", OS.get_real_window_size())
	print("Viewport size:", get_viewport().get_size())
	print("ViewportRect size:", get_viewport_rect().size)
		
	var has_created = false;
	has_created = _create_top_card()
	has_created = _create_bottom_card()
	
	if(!has_created):
		print("Failed to create top/bottom cards")


#func myfunc():
#	print("Resizing: ", get_viewport_rect().size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func TestMethod():
	print("This is a test method.")
	pass

func _create_bottom_card():
	_new_card = preload("res://Scenes/Card.tscn").instance()
	var pos = Vector2(1950,1120)
	_new_card.set_position(pos)
	get_node("Area2D/Sprite").add_child(_new_card)
	return true;

func _create_top_card():
	_new_card = preload("res://Scenes/Card.tscn").instance()
	var pos = Vector2(425,-30)
	_new_card.set_position(pos)
	get_node("Area2D/Sprite").add_child(_new_card)
	return true;
