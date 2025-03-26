extends Node2D

signal mouse_entered(card: Card)
signal mouse_exited(card: Card)
#signal On_Click



func highlight():
	$Card.highlight()

func unhighlight():
	$Card.unhighlight()


func _on_card_mouse_entered(card: Card) -> void:
	mouse_entered.emit(card)

func _on_card_mouse_exited(card: Card) -> void:
	mouse_exited.emit(card)
