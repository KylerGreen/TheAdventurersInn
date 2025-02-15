@tool
class_name Hand
extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = -90
@export var angle_limit: float = 20
@export var max_card_spread_angle: float = 5


@onready var test_card = $ActionSwing
@onready var collision_shape: CollisionShape2D = $DebugShape

# Holds the cards in an array
var in_hand : Array = []

func add_card(card: Node2D):
#	Adds a card physically; Sort via position
	in_hand.push_back(card)
	reposition_cards()
#
func reposition_cards():
	var card_spread = min(angle_limit / in_hand.size(), max_card_spread_angle)
	var current_angle = -(card_spread * in_hand.size())-90
	for card in in_hand:
		update_card_transform(card, current_angle)
		current_angle += card_spread
		

func get_card_position(angle_in_degree: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_degree))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_degree))
	
	return Vector2(x,y)
	
func update_card_transform(card: Node2D, angle_in_drag: float):
	card.set_position(get_card_position(angle_in_drag))
	card.set_rotation(deg_to_rad(angle_in_drag+90))

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# tool logic
	if (collision_shape.shape as CircleShape2D).radius != hand_radius:
		(collision_shape.shape as CircleShape2D).set_radius(hand_radius)

	test_card.set_position(get_card_position(card_angle))
	
	# Card remains upright regardless of where it is on the circle
	test_card.set_rotation(deg_to_rad(0))
	# Rotates the cards perpendicular to the circles curvature
		#test_card.set_rotation(deg_to_rad(card_angle+90))

	
	
#	Thinky about Numbers
#	-90dg -> rotat 0
#	-45dg -> rotat 45
#	-135dg -> rotat -45
