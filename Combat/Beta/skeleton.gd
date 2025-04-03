extends CharacterBody2D


func _ready():
	$"Skeleton Animation".play("Idle")
	CombatSignals.Enemy_Swing.connect(attack_anim)
	CombatSignals.Player_Swing.connect(hurt_anim)
	CombatSignals.Enemy_Parry.connect(block_anim)
	
func attack_anim():
	$"Skeleton Animation".play("Attack")


func _on_skeleton_animation_animation_finished() -> void:
	$"Skeleton Animation".play("Idle")
	
func hurt_anim():
	$"Skeleton Animation".play("Hurt")

func block_anim():
	$"Skeleton Animation".play("Block")
