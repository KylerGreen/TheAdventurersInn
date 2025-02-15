extends Node2D

signal On_Click

func on_On_CLick():
	CombatSignals.Action_Set.emit()

func on_Player_Action():
	CombatSignals.Player_Attack.emit()
