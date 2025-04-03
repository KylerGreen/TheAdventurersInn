extends CharacterBody2D

#Player Stats
var HP = 100
var MaxHP = 100
var Heals = 15
var Damage = 30
var XP = 0
var Level = 1

#Player Inventory
var Gold = 0
var Sword = 0
var Armor = 0

#Combat States
var Bolster = 1
var Dodge = false
var Parry = 1
var Counter = false
var disarm = false

#Other Variables
var has_action = false
var has_reaction = false
var action_card
var reaction_card

func _ready():
	HP = CombatSignals.Player_HP
	%Player_HP.text = str('HP: ', HP)
	CombatSignals.Player_Bolster.connect(Bolstered)
	CombatSignals.Player_Dodge.connect(Dodging)
	CombatSignals.Player_Parry.connect(Parrying)
	CombatSignals.Player_Counter.connect(Countering)
	CombatSignals.Player_Heal.connect(Healing)
	CombatSignals.card_placed.connect(player_turn)
	
	CombatSignals.Enemy_Swing.connect(Damaged)
	CombatSignals.Enemy_Disarm.connect(Disarmed)
	%"BattleMusic".play()
	
func _process(delta):
	%Player_HP.text = str('HP: ', HP)
	$Player_health.value = HP
	if HP <= 0:
		HP = 0
		get_tree().change_scene_to_file("res://Game Over Screen/game_over_screen.tscn")
	Gold = DungeonSignals.gold
	if HP >= MaxHP:
		HP = MaxHP
	
	if XP >= 100:
		if Level == 1:
			MaxHP = 120
			HP = MaxHP
			Level += 1
			DungeonSignals.DisplayText.emit('You Leveled Up!')
	elif XP >= 300:
		if Level == 2:
			HP = MaxHP
			Level += 1
			DungeonSignals.DisplayText.emit('You Leveled Up!')
	elif XP >= 700:
		if Level == 3:
			MaxHP = 160
			HP = MaxHP
			Level += 1
			DungeonSignals.DisplayText.emit('You Leveled Up!')
	
	if %Enemy.HP <= 0:
		await get_tree().create_timer(1.5).timeout
		CombatSignals.Player_HP = HP
		%Enemy.HP = 0
		DungeonSignals.gold += %Enemy.gold
		XP += %Enemy.XP
		DungeonSignals.combat_done.emit()
		


func Bolstered():
	Bolster = 1.5
	%Player_damaged.text = str('You bolster your next attack!')
	await get_tree().create_timer(1.0).timeout
	%Player_damaged.text = str('')
	
func Dodging():
	Dodge = true
	%Player_damaged.text = str('You prepare to Dodge!')
	await get_tree().create_timer(1.0).timeout
	%Player_damaged.text = str('')
	
func Parrying():
	Parry = 0.5
	%Player_damaged.text = str('You prepare to Parry!')
	await get_tree().create_timer(1.0).timeout
	%Player_damaged.text = str('')
	
func Countering():
	Counter = true
	%Player_damaged.text = str('You prepare to Counter!')
	await get_tree().create_timer(1.0).timeout
	%Player_damaged.text = str('')
	
func Healing():
	HP += Heals
	%Player_damaged.text = str('+', Heals)
	await get_tree().create_timer(1.0).timeout
	%Player_damaged.text = str('')

func Damaged():
	var DMG_Recieved = %Enemy.Damage * %Enemy.Bolster * Parry
	
	if Dodge == true:
		HP = HP
		Dodge = false
		%Player_damaged.text = str('You Dodged the Attack!')
		await get_tree().create_timer(1.0).timeout
		%Player_damaged.text = str('')
	elif Counter == true:
		HP -= DMG_Recieved
		%Enemy.HP -= ((Damage + Sword) * 0.5)
		%DamageCounter.text = str('-',((Damage + Sword) * 0.5))
		await get_tree().create_timer(1.0).timeout
		%DamageCounter.text = str('')
		Counter = false
	else:
		HP -= DMG_Recieved
		%Player_damaged.text = str('-',DMG_Recieved)
		await get_tree().create_timer(1.0).timeout
		%Player_damaged.text = str('')
	%Enemy.Bolster = 1
	Parry = 1
	
func Disarmed():
	%Enemy.Disarm = true
	
func player_turn(card, container):
	Dodge = false
	
	if container.unique_id == CombatSignals.new_act_id:
		has_action = true
		action_card = card.card_info
		if action_card["type"] == "Reaction":
			has_action = false
	elif container.unique_id == CombatSignals.new_react_id:
		has_reaction = true
		reaction_card = card.card_info
		if reaction_card["type"] == "Action":
			has_reaction = false
			
	if has_action == true and has_reaction == true:
		if reaction_card["name"] == "Parry":
			CombatSignals.Player_Parry.emit()
		elif reaction_card["name"] == "Dodge":
			CombatSignals.Player_Dodge.emit()
		elif reaction_card["name"] == "Counter":
			CombatSignals.Player_Counter.emit()
		elif reaction_card["name"] == "Bolster":
			CombatSignals.Player_Bolster.emit()
			
		if action_card["name"] == "Disarm":
			CombatSignals.Enemy_Disarm.emit()
		elif action_card["name"] == "Heal":
			CombatSignals.Player_Heal.emit()
		elif action_card["name"] == "Swing":
			CombatSignals.Player_Swing.emit()
		
		CombatSignals.invis_hand.emit()
		has_action = false
		has_reaction = false
		CombatSignals.card_used.emit(container.unique_id)	
		CombatSignals.player_turn_over.emit()
		
	elif container.unique_id == CombatSignals.discard_id:
		CombatSignals.card_used.emit(container.unique_id)
