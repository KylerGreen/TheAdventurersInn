extends Node

@onready var card_manager = $CardManager
@onready var card_factory = $CardManager/CardFactory
@onready var hand = $CardManager/Hand
@onready var act_zone = $CardManager/Action
@onready var react_zone = $CardManager/Reaction
@onready var deck = $CardManager/Deck
@onready var discard = $CardManager/Discard

# Use to read player "decklist.json" filled with file names, sans .json
#var deck_list = "res://Combat/Beta/player_decklist.json"
#var json_as_text = FileAccess.get_file_as_string(deck_list)
#var deck_as_dict = JSON.parse_string(json_as_text)


# Called when the node enters the scene tree for the first time.
func _ready():
	_reset_deck()


func _reset_deck():
	var list = _get_randomized_card_list()
	deck.clear_cards()
	for card in list:
		card_factory.create_card(card, deck)


func _get_randomized_card_list() -> Array:
	#var suits = ["act", "react"]
	var values = ["act_disarm", "act_heal", "act_swing", "react_bolster", "react_counter", "react_dodge", "react_parry"]
	
	var card_list = []

	for value in values:
		#card_list.append("%s_%s" % [suit, value])
		card_list.append(value)
	
	card_list.shuffle()
	
	return card_list


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
