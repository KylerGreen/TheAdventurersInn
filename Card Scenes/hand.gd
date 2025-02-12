@tool
class_name Hand
extends Node2D

@export var hand_radius: int = 100
@export var card_angle: float = 90
@export var angle_limit: float = 20

@onready var test_card = $ActionSwing
@onready var collision_shape: CollisionShape2D = $DebugShape

var in_hand : Array = []

#func add_card(card: Node2D):
##	Adds a card physically
##	Sort via position
	#hand.push_back(card)
#
#func reposition_cards():
##	Limit angle between -110 and -70 degrees; 20dg from top
	#for card in hand:
		#pass

func get_card_position(angle_in_degree: float) -> Vector2:
	var x: float = hand_radius * cos(deg_to_rad(angle_in_degree))
	var y: float = hand_radius * sin(deg_to_rad(angle_in_degree))
	
	return Vector2(x,y)
	
func _card_transform_update(card: Node2D, angle_in_drag: float):
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
	
# Rotates the cards perpendicular to the circles curvature
	#test_card.set_rotation(deg_to_rad(card_angle+90))
# NOTE: MAKE CARD ROTATION UNAFFECTED BY THE ANGULAR POSITIONING
	test_card.set_rotation(deg_to_rad(card_angle))
	
	
#	Thinky about Numbers
#	-90dg -> rotat 0
#	-45dg -> rotat 45
#	-135dg -> rotat -45
