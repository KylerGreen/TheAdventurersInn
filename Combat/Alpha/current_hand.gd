extends Control

signal attack
signal defend
signal heal
signal counter
signal dodge



func _on_attack_pressed():
	attack.emit()


func _on_defend_pressed():
	defend.emit()


func _on_counter_pressed():
	counter.emit()


func _on_heal_pressed():
	heal.emit()


func _on_dodge_pressed():
	dodge.emit()
