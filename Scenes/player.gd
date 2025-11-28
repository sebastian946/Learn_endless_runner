extends CharacterBody3D


@export var Speed = 10.0
@export var JumpVelocity = 4.5
@export var LaneChangeSpeed = 5.0
@export var LaneWidth = 2.0


enum Lane {LEFT =1, CENTER = 0,RIGHT=-1 }
enum State {RUNNING, JUMPING, SLIDING, DEAD}

var targetLane: int = Lane.CENTER
var currentLane: int = Lane.CENTER

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JumpVelocity
	
	var targetX = targetLane * LaneWidth
	position.x = lerp(position.x, targetX,LaneChangeSpeed * delta)
	if Input.is_action_just_pressed("ui_right") and targetLane < Lane.LEFT:
		targetLane += 1
	if Input.is_action_just_pressed("ui_left") and targetLane > Lane.RIGHT:
		targetLane -= 1
	

	move_and_slide()
