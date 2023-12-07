class_name FloatingPickupTextHelper

var spawnPosition: Vector2
var textToSpawn: Array[Label]
var countdownTime: float = 0.0

func _init(_position: Vector2):
	self.spawnPosition = _position
	
func countDownAndPopIfTimeElapsed(delta) -> Label:
	countdownTime -= delta
	if countdownTime <= 0.0:
		countdownTime += 0.7
		return textToSpawn.pop_front()
	return null
