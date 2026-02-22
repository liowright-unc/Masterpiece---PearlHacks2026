extends Node2D

const SCENES = ["opening", "res://CatchGame.tscn", "America_fin", "France", "res://CatchGame.tscn", "France_fin", "China", "res://CatchGame.tscn", "China_fin"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _opening = load("res://timelines/opening.dtl")
	var _catchgame_scene = load("res://CatchGame.tscn")
	var _America_fin = load("res://timelines/America_fin.dtl")
	SignalBus.finished_catchgame.connect(add_to_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	SignalBus.current_control = SCENES[SignalBus.current_scene_num]
	control(SignalBus.current_control)

func control(current) -> void: #which timeline/minigame
	
	if SignalBus.current_scene_num == 9:
		get_tree().quit()
	
	if current == "opening" or current == "America_fin" or current == "France" or current == "France_fin" or current == "China" or current == "China_fin": #if it's a timeline
		if Dialogic.current_timeline != null: #prevent simultaneous
			return
		else: 
			Dialogic.paused = false
			Dialogic.start(current)
			await Dialogic.timeline_ended
			Dialogic.paused = true
			SignalBus.current_scene_num += 1
			
	else: #if it's a minigame
		SignalBus.current_scene_num += 1
		get_tree().change_scene_to_file(current)
	
func add_to_score(add) -> void:
	SignalBus.final_score += add
	print(SignalBus.final_score)
	
