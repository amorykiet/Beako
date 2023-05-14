extends Area2D


func _on_body_entered(body):
	GamePlayProgress.checkpoint = global_position
