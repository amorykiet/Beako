extends Node2D

#func _ready():
#    set_process(true)
#
#func _process(delta):
#    time_now = OS.get_unix_time()
#    var elapsed = time_now - time_start
#    var minutes = elapsed / 60
#    var seconds = elapsed % 60
#    var str_elapsed = "%02d : %02d" % [minutes, seconds]
#    print("elapsed : ", str_elapsed)

func _ready():
	GamePlayProgress.time_start = Time.get_unix_time_from_system()
	GamePlayProgress.deaths = 0
	GamePlayProgress.fruits_collected = 0
	GamePlayProgress.checkpoint = $Subaru.position
	
func _unhandled_input(event):
	if Input.is_action_just_pressed("ReplayLevel"):
		$Subaru.transition_to("Dead")
	if Input.is_action_just_pressed("ReplayGame"):
		get_tree().reload_current_scene()

func _on_victory_area_body_entered(body):
	GamePlayProgress.time_end = Time.get_unix_time_from_system()
	get_tree().change_scene_to_file("res://victory_scene.tscn")
