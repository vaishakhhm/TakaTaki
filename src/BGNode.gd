extends Node2D

var _new_top_card_node = null
var _new_bottom_card_node = null

var _old_top_card_node = null
var _old_bottom_card_node = null

var topPlayerCards = null
var bottomPlayerCards = null

var total_top_cards = 20
var total_bottom_cards = 20

var old_total_top_cards = total_top_cards
var old_total_bottom_cards = total_bottom_cards

var radialProgress = null

const _1 = "res://Asset/Elemental_Cards/Fire/1.png"
const _2 = "res://Asset/Elemental_Cards/Fire/2.png"
const _3 = "res://Asset/Elemental_Cards/Fire/3.png"
const _4 = "res://Asset/Elemental_Cards/Fire/4.png"
const _5 = "res://Asset/Elemental_Cards/Fire/5.png"
const _6 = "res://Asset/Elemental_Cards/Fire/6.png"
const _7 = "res://Asset/Elemental_Cards/Fire/7.png"
const _8 = "res://Asset/Elemental_Cards/Fire/8.png"
const _9 = "res://Asset/Elemental_Cards/Fire/9.png"
const _10 = "res://Asset/Elemental_Cards/Fire/10.png"

const _11 = "res://Asset/Elemental_Cards/Earth/1.png"
const _12 = "res://Asset/Elemental_Cards/Earth/2.png"
const _13 = "res://Asset/Elemental_Cards/Earth/3.png"
const _14 = "res://Asset/Elemental_Cards/Earth/4.png"
const _15 = "res://Asset/Elemental_Cards/Earth/5.png"
const _16 = "res://Asset/Elemental_Cards/Earth/6.png"
const _17 = "res://Asset/Elemental_Cards/Earth/7.png"
const _18 = "res://Asset/Elemental_Cards/Earth/8.png"
const _19 = "res://Asset/Elemental_Cards/Earth/9.png"
const _20 = "res://Asset/Elemental_Cards/Earth/10.png"

var top_deck_array = [_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20 ]
var bottom_deck_array = [_1, _2, _3, _4, _5, _6, _7, _8, _9, _10, _11, _12, _13, _14, _15, _16, _17, _18, _19, _20 ]

var drawCardArray = Array()
var nodeArray = Array()

var sparkleNode = preload("res://Scenes/Effects.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	#get_tree().get_root().connect("size_changed", self, "myfunc")
	
	topPlayerCards = $Area2D/TopPlayerCards
	bottomPlayerCards = $Area2D/BottomPlayerCards
	radialProgress = get_node("Area2D/TextureProgress")
	
	topPlayerCards.text = "Cards left: " + String(total_top_cards)
	bottomPlayerCards.text = "Cards left: " + String(total_bottom_cards)
	
	#print("Window size:", OS.get_real_window_size())
	#print("Viewport size:", get_viewport().get_size())
	#print("ViewportRect size:", get_viewport_rect().size)
		
	var has_created = false;
	
	has_created = _create_top_card(true)
	has_created = _create_bottom_card(true)
	
	if(!has_created):
		print("Failed to create top/bottom cards")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if total_top_cards != old_total_top_cards:
		topPlayerCards.text = "Cards left: " + String(total_top_cards)
		old_total_top_cards = total_top_cards
		
	if total_bottom_cards != old_total_bottom_cards:
		bottomPlayerCards.text = "Cards left: " + String(total_bottom_cards)
		old_total_bottom_cards = total_bottom_cards
	
#	radialProgress.set_fill_mode(4)
#	for i in range(100):
#			radialProgress.value += 1
#	pass

func TestMethod():
	print("This is a test method.")
	pass

func _create_bottom_card(var initialCard):
	if(total_bottom_cards > 0):
		_new_bottom_card_node = preload("res://Scenes/Card.tscn").instance()
		var pos = Vector2(1950,1120)
		_new_bottom_card_node.set_position(pos)
		var card = findNextBottomRandomCard()
		if(card == null):
			total_bottom_cards -= 1
			return true
		else:
			_new_bottom_card_node._init()
			_new_bottom_card_node.sprite_node.set_texture(load(card))
			get_node("Area2D/Sprite").add_child(_new_bottom_card_node)
			_old_bottom_card_node = _new_bottom_card_node
			
		if (!initialCard):
			total_bottom_cards -= 1
		return true
	else:
		return false

func _create_top_card(var initialCard):
	if(total_top_cards > 0):
		_new_top_card_node = preload("res://Scenes/Card.tscn").instance()
		var pos = Vector2(425,-30)
		_new_top_card_node.set_position(pos)
		var card = findNextTopRandomCard()
		
		if(card == null):
			total_top_cards -= 1
			return false
		else:
			_new_top_card_node._init()
			_new_top_card_node.sprite_node.set_texture(load(card))
			get_node("Area2D/Sprite").add_child(_new_top_card_node)
			_old_top_card_node = _new_top_card_node
			
		if (!initialCard):
			total_top_cards -= 1
		return true
	else:
		return false


func findNextBottomRandomCard():
	randomize()
	bottom_deck_array.shuffle()
	return bottom_deck_array.pop_back()

func findNextTopRandomCard():
	randomize()
	top_deck_array.shuffle()
	return top_deck_array.pop_back()


func checkForMatchingNodes():
	var hasMatched = false;
	var regex = RegEx.new()
	regex.compile("[0-9]+")
	if(drawCardArray.size() >= 2):
		var lastCard = drawCardArray[-1]
		var slCard = drawCardArray[-2]
		lastCard = regex.search(lastCard)
		slCard = regex.search(slCard)
		
		print ("Comparing Nodes: ", lastCard.get_string(), " and " , slCard.get_string())
		
		var firstNumber = lastCard.get_string()
		var secondNumber = slCard.get_string()
		
		
		if(firstNumber == secondNumber):
			playMatchingAnimation()
			print("Card matches")
			
	return hasMatched


func AddNodeForMatching(var cardNode):
	#print("Added node: ", cardNode.sprite_node.texture.resource_path)
	drawCardArray.push_back(cardNode.sprite_node.texture.resource_path)

func playMatchingAnimation():
	var pos = Vector2((get_viewport_rect().size.x / 2) + 400, get_viewport_rect().size.y / 2)
	sparkleNode.set_position(pos)
	var animPlayer = sparkleNode.get_node("AnimationPlayer")
	get_node("Area2D/Sprite").add_child(sparkleNode)
	animPlayer.play("SparkleAnimation")
