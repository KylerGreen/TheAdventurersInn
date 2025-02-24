@tool
class_name Card extends Node2D


signal mouse_entered(card: Card)
signal mouse_exited(card: Card)

@export var card_name: String = "Card Name"
@export var card_ability: String = "Card Ability"
@export var card_rank: int = 1
@export var card_image: Sprite2D
@export var action_reaction: String = "Re?Action"

@onready var name_lbl: Label = $CardBackground/Name
@onready var cr_display: Label = $CRDisplay/CR_Label
@onready var ability_lbl: Label = $AbilityBox/Ability
@onready var re_action: Label = $ActionReaction/Action_Or_Reaction

# Used for Highlighting the cards
# Doesn't address the issue of highlighting multiple cards, replaced with signals
@onready var card_background: Sprite2D = $CardBackground
@onready var card_textbox: Sprite2D = $AbilityBox/Textbox
@onready var card_cr: Sprite2D = $CRDisplay/CrRating

func _ready():
	set_card_values(card_rank, card_name, card_ability, action_reaction)
	

func set_card_values(_cr: int, _name: String, _card_ability: String, _action_reaction: String):
	card_name = _name
	card_rank = _cr
	card_ability = _card_ability
	action_reaction = _action_reaction
	
	
	update_graphics()
	#name_lbl.set_text(_name)
	#cr_display.set_text(str(_cr))
	#ability_lbl.set_text(_card_ability)
	#re_action.set_text(_action_reaction)
	
func update_graphics():
	if name_lbl.get_text() != card_name:
		name_lbl.set_text(card_name)
	if cr_display.get_text() != str(card_rank):
		cr_display.set_text(str(card_rank))
	if ability_lbl.get_text() != card_ability:
		ability_lbl.set_text(card_ability)
	if re_action.get_text() != action_reaction:
		re_action.set_text(action_reaction)

	name_lbl.set_text(card_name)
	cr_display.set_text(str(card_rank))
	ability_lbl.set_text(card_ability)
	re_action.set_text(action_reaction)




func activate():
	pass

func _process(delta):
	update_graphics()


func highlight(card: Card):
	self.card_background.set_modulate(Color(1, 0.5, 0.1, 1))
	print("PRINTING")
	#card_textbox.set_modulate(Color(1, 0.5, 0.1, 1))
	#card_cr.set_modulate(Color(1, 0.5, 0.1, 1))
	
func unhighlight(card: Card):
	self.card_background.set_modulate(Color(1, 1, 1, 1))
	#card_textbox.set_modulate(Color(1, 1, 1, 1))
	#card_cr.set_modulate(Color(1, 1, 1, 1))
	pass
	
func _on_area_2d_mouse_entered():
	highlight(self)
	mouse_entered.emit(self)


func _on_area_2d_mouse_exited():
	unhighlight(self)
	mouse_exited.emit(self)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	pass # Replace with function body.
