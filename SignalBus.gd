extends Node

signal finished_catchgame(score)
signal item_caught

var current_scene_num = 0
var current_control = "opening"
var final_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
