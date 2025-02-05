extends Node2D

const SPAWN_ROOMS: Array = [preload("res://Rooms/Beginner Rooms/beginner_room_1_r.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_2_uld.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_3_u.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_4_d.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_5_l.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_6_lr.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_7uldr.tscn"), 
preload("res://Rooms/Beginner Rooms/beginner_room_8_ud.tscn")]

const INTERMEDIATE_ROOMS: Array = [preload("res://Rooms/Intermediate Rooms/intermediate_room_1.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_2.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_3.tscn"), 
preload("res://Rooms/Intermediate Rooms/intermediate_room_4.tscn")]

const END_ROOMS: Array = [preload("res://Rooms/Advanced Rooms/advanced_room_1.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_2.tscn"),
preload("res://Rooms/Advanced Rooms/advanced_room_3.tscn"), 
preload("res://Rooms/Advanced Rooms/advanced_room_4.tscn")]

onready var player: KinematicBody2D = get_node("res://Combat/Player/player.tscn")

func _ready() -> void 
	_spawn_rooms()
	
func _spawn_rooms() -> void 
	var room_count := 5
	var previous_rooms: Node2D = null
	var room_posiiton := Vector2(0,0)
	
