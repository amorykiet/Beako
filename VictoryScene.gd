extends CanvasLayer

func _ready():
	var elapsed = GamePlayProgress.time_end-GamePlayProgress.time_start
	var minutes = elapsed / 60
	var seconds = elapsed % 60
	var str_elapsed = "%02d : %02d" % [minutes, seconds]
	%Deaths.text = str(GamePlayProgress.deaths)
	%Fruits.text = str(GamePlayProgress.fruits_collected)
	%Time.text = str(str_elapsed)

func _unhandled_input(event):
	if event.is_action_pressed("ReplayGame"):
		get_tree().change_scene_to_file("res://game.tscn")
