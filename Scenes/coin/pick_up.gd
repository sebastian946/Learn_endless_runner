extends Area3D

class_name Pickup

enum PickupType {COIN, POWERUP, BOOST}
@export var Score = 1
@export var Speed : float = 10.0

func _process(delta: float) -> void:
	position.z += Speed * delta
