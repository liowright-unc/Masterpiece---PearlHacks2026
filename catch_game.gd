extends Node2D

var score = 0
var rng = RandomNumberGenerator.new()
@onready var spawntimer = $SpawnTimer
const falling_item: PackedScene = preload("res://falling_item.tscn")

## keep score
## start screen: five seconds before timer start
## display timer after 5 seconds pass


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var catch_timer = get_node("Timer")
	catch_timer.timeout.emit(end_screen)
	
	var items_caught = get_node("FallingItem")
	items_caught.caught.emit(get_score)
	
	var spawn_time = get_node("SpawnTimer")
	spawn_time.timeout.emit(spawn)
	
	#5 seconds to game start
	await get_tree().create_timer(5).timeout
	spawntimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spawn() -> void:
	var new_instance = falling_item.instantiate()
	new_instance.global_position = Vector2(rng.randi_range(0,600), 600)
	add_child(new_instance)

func get_score() -> void:
	score += 10
	
func end_screen() -> void:
	## calculuate score
	## show score
	## on click, send signal to switch (done!)
	SignalBus.finished_catchgame.emit(score)
