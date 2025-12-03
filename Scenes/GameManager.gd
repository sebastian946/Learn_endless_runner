extends Node3D

signal ScoreUpdated(score:int) 

@export var ObstacleScene: Array[PackedScene] = []
@export var PowerUpScene: Array[PackedScene] = []
@export var MinSpawnTime: float = 1.0
@export var MaxSpawnTime: float = 2.0
@export var SpawnDistance: float = -20.0
@export var PickUpableSpawnChance : float = .3


var score: int = 0
var lanePosition = [-2.0,0.0, 2.0]


func _on_spawn_timer_timeout() -> void:
	var randValue = randf()
	if randValue < PickUpableSpawnChance:
		var obstacleScene = PowerUpScene[randi() % PowerUpScene.size()]
		var currentOB = obstacleScene.instantiate()
		var spawnLane = randi() % 3
		currentOB.position = Vector3(lanePosition[spawnLane], 0, SpawnDistance)
		$ObstacleContainer.add_child(currentOB)
	else:
		var obstacleScene = ObstacleScene[randi() % ObstacleScene.size()]
		var currentOB = obstacleScene.instantiate()
		if currentOB.CurrentObstacleType == Obstacle.ObstacleType.LOW or currentOB.CurrentObstacleType == Obstacle.ObstacleType.HIGH:
			var obstacle = obstacleScene.instantiate()
			obstacle.position = Vector3(0, 0,SpawnDistance)
			$ObstacleContainer.add_child(obstacle)
			currentOB.queue_free()
		else:
			var openLane = randi() % 3
			for i in range(3):
				if i != openLane:
					var obstacle = obstacleScene.instantiate()
					obstacle.position = Vector3(lanePosition[i], 0,SpawnDistance)
					$ObstacleContainer.add_child(obstacle)
			currentOB.queue_free()


func _on_score_timer_timeout() -> void:
	score += 1
	ScoreUpdated.emit(score)
	pass # Replace with function body.


func _on_player_add_score(score: int) -> void:
	self.score += score
	ScoreUpdated.emit(score)
	pass # Replace with function body.
