extends Timer

func _on_timeout() -> void:
	CombatSignals.Player_Bolster.emit()
	CombatSignals.Player_Attack.emit()
