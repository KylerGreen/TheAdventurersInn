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
	CombatSignals.card_used.connect(_end_of_turn)
	_reset_deck()
	_draw_to_five()


func _reset_deck():
	var list = _get_randomized_card_list()
	deck.clear_cards()
	for card in list:
		card_factory.create_card(card, deck)


func _get_randomized_card_list() -> Array:
	# Test inputs for Decklist
	var values = ["act_disarm", "act_disarm", "act_heal", "act_heal", "act_heal", "act_swing", "act_swing", "act_swing", "act_swing", "act_swing", "act_swing", "react_bolster", "react_bolster", "react_bolster", "react_counter", "react_counter", "react_dodge", "react_dodge", "react_parry", "react_parry"]
	#var values = ["act_disarm", "act_disarm", "act_disarm", "act_disarm", "act_disarm", "act_disarm"]
	
	var card_list = []

	for value in values:
		card_list.append(value)
	
	card_list.shuffle()
	
	return card_list


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _draw_to_five():
	var current_draw_number = 5
	while current_draw_number > 0:
		var result = hand.move_cards(deck.get_top_cards(current_draw_number))
		if result:
			break
		current_draw_number -= 1

func _end_of_turn():
	# Send signals from the cards to the card_signal Manager
	
	# Discard Cards from Action and reaction zone
	var cards = act_zone.get_top_cards(1) + react_zone.get_top_cards(1)
	discard.move_cards(cards)
	var current_draw_number = 2
	while current_draw_number > 0:
		var result = hand.move_cards(deck.get_top_cards(current_draw_number))
		if result:
			break
		current_draw_number -= 1
	

func _on_discard_test_pressed() -> void:
	_end_of_turn()
