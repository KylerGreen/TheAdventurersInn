extends Node

#Initializes the nodes in card_handler.tscn
@onready var card_manager = $CardManager
@onready var card_factory = $CardManager/CardFactory
@onready var hand = $CardManager/Hand
@onready var act_zone = $CardManager/Action
@onready var react_zone = $CardManager/Reaction
@onready var deck = $CardManager/Deck
@onready var discard = $CardManager/Discard

# Initializes path to the decklist.json
@onready var deck_list = "res://Combat/Beta/player_decklist.json"
@onready var cards_left := 0


func load_from_file():
	var file = FileAccess.open("res://Combat/Beta/player_decklist.json", FileAccess.READ)
	var content = file.get_as_text()
	return content
# Use to read player "decklist.json" filled with file names, sans .json
#var deck_list = "res://Combat/Beta/player_decklist.json"
#var json_as_text = FileAccess.get_file_as_string(deck_list)
#var deck_as_dict = JSON.parse_string(json_as_text)


# Called when the node enters the scene tree for the first time.
func _ready():
	print(load_from_file())
	CombatSignals.card_used.connect(_end_of_turn)
	CombatSignals.card_placed.connect(_card_type_check)
	_reset_deck()
	_draw_to_five()


func _parse_decklist_json():
	var file_path = deck_list
	var file = FileAccess.open(file_path, FileAccess.READ)
	
	if file:
		var content = file.get_as_text()
		var json = JSON.new()
		var parse_result = json.parse(content)
		
		if parse_result == OK:
			var data = json.data
			if "DeckList" in data:
				deck_list = data["DeckList"]
				print("Deck List:", deck_list)
			else:
				print("DeckList key not found in JSON.")
		else:
			print("Failed to parse JSON.")
	else:
		print("Failed to open file.")
		return deck_list


func _reset_deck():
	var list = _get_randomized_card_list()
	deck.clear_cards()
	for card in list:
		card_factory.create_card(card, deck)


func _get_randomized_card_list() -> Array:
	# Test inputs for Decklist
	_parse_decklist_json()
	#print(deck_list)
	var current_deck = deck_list
	#var current_deck = ["act_disarm", "act_disarm", "act_heal", "act_heal", "act_swing", "act_swing", "act_swing", "act_swing", "act_swing", "act_swing", "act_swing", "react_bolster", "react_bolster", "react_bolster", "react_counter", "react_counter", "react_dodge", "react_parry", "react_parry", "react_parry"]
	
	var card_list = []

	for value in current_deck:
		card_list.append(value)
		cards_left += 1
		print(cards_left)
	
	card_list.shuffle()
	
	#print(card_list)
	return card_list



func _draw_to_five():
	var current_draw_number = 5
	while current_draw_number > 0:
		var result = hand.move_cards(deck.get_top_cards(current_draw_number))
		if result:
			break
		current_draw_number -= 1

# WIP
# Update a Label to Reflect the total count of cards in the Deck Pile
func show_card_count():
	pass
	
	

# Takes a Action/Reaction Card and it's Action/Reaction Pile
# If Both holds_x is true, and card type == x, card stays in the pile
# else, the card is ejected back to the hand
func _card_type_check(card, container):
	var player_node = 	get_parent().get_node("Player")
	
	var holds_action = false
	var holds_reaction = false
	# container.unique_id == 1 is the Action Pile
	if container.unique_id == CombatSignals.new_act_id:
		holds_reaction = false
		holds_action = true
	# conntainer.unique_id == 2 is the Reaction Pile
	elif container.unique_id == CombatSignals.new_react_id:
		holds_reaction = true
		holds_action = false

	var data = card.card_info
	
	# For Adding a card to the Action Pile
	if data["type"] == "Action" and  holds_action == true:
		pass
	elif data["type"] == "Reaction" and  holds_reaction == false:
		hand.move_cards(act_zone.get_top_cards(1))
		#player_node.has_action = false	# Disable when Testing independant of Combat_2.tscn
	
	# For Adding a card to the Action Pile
	elif data["type"] == "Reaction" and  holds_reaction == true:
		pass
	elif data["type"] == "Action" and  holds_action == false:
		hand.move_cards(react_zone.get_top_cards(1))
		#player_node.has_reaction = false	# Disable when Testing independant of Combat_2.tscn

func _end_of_turn(container_id):
	# Send signals from the cards to the card_signal Manager
	
	if container_id == CombatSignals.discard_id:
		var current_draw_number = 1
		while current_draw_number > 0:
			var result = hand.move_cards(deck.get_top_cards(current_draw_number))
			if result:
				break
			current_draw_number -= 1
		# Updates the display of the number of cards left in the deck
		cards_left -= 1
		$"CardManager/Deck/Card countings".text = str(cards_left," Cards Left")
		print(cards_left)

	elif container_id == CombatSignals.new_act_id or container_id == CombatSignals.new_react_id:
		var cards = act_zone.get_top_cards(1) + react_zone.get_top_cards(1)
		discard.move_cards(cards)
		var current_draw_number = 2
		while current_draw_number > 0:
			var result = hand.move_cards(deck.get_top_cards(current_draw_number))
			if result:
				break
			current_draw_number -= 1
			# Updates the display of the number of cards left in the deck
			cards_left -= 1
			$"CardManager/Deck/Card countings".text = str(cards_left," Cards Left")
			print(cards_left)
	

#func _on_discard_test_pressed() -> void:
	#_end_of_turn()
