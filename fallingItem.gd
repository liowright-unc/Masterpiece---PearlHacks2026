extends Area2D

const FALL_SPEED = 200
signal catch


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += FALL_SPEED * delta
	
	if position.y > 600:
		queue_free()
		
func _on_area_entered(area) -> void:
	if area.name == "Player":
		catch.emit()
		queue_free()
