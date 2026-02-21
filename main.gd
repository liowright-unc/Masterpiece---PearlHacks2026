extends Node2D

const SCENES = ["opening", "catchgame"]
var current_scene_num = 0
var current_control = SCENES[current_scene_num]

var score = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var catchgame_scene = preload("res://CatchGame.tscn")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	control(current_control)


func control(current) -> void: #which timeline/minigame
	
	if current == "opening": #if it's a timeline
		if Dialogic.current_timeline != null: #prevent simultaneous
			return
		else: 
			get_tree().change_scene_to_file(current)
			Dialogic.start(current)
			get_viewport_rect()
			await Dialogic.timeline_ended
	else: #if it's a minigame
		get_tree().change_scene_to_file(current)
		await SignalBus.finished_catchgame
	current_scene_num += 1
