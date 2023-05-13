extends Area2D

func _on_body_entered(body):
	if body.name == "Subaru":
		body as Subaru
		body.cur_stama = body.MAX_STAMA
#		body.fruits_collecting += 1
		GamePlayProgress.fruits_collecting += 1
		body.can_dash = true
		queue_free()
