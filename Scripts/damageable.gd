extends Node

class_name damageable

@export var kill_node: Node
@export var health: float
@export var max_health: float
@export var min_health: float
@export var health_bar: Node3D


func change_health(amount):
	if health + amount < min_health:
		health = min_health
		die()
	elif health + amount > max_health:
		health = max_health
	else:
		health += amount 
	
	health_bar.scale.x = health/max_health * 10

func die():
	kill_node.queue_free()
