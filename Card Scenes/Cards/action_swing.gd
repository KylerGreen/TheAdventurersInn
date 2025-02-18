extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
signal On_Click

func on_On_CLick():
	CombatSignals.Action_Set.emit()

func on_Player_Action():
	CombatSignals.Player_Attack.emit()




func _on_card_mouse_entered(card: Card):
	mouse_entered.emit(card)

func _on_card_mouse_exited(card: Card):
	mouse_exited.emit(card)
