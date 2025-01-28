extends CharacterBody2D

var health = 10

func _ready():
	%Player_Animation.play("Idle")

func _on_button_pressed():
	%Arm_Animation.visible = true
	%Player_Animation.play("Attack")
	%Arm_Animation.play("Attack")
	%Timer.start()

func _on_timer_timeout():
	%Timer.stop()
	%Player_Animation.stop()
	%Arm_Animation.stop()
	%Arm_Animation.visible = false
	%Player_Animation.play("Idle")
