extends Area2D

func _on_body_entered(body):
	if body.name == "Subaru":
		body as Subaru
		body.cur_stama = body.MAX_STAMA
		GamePlayProgress.fruits_collecting += 1
		body.can_dash = true
		$Sprite2D.hide()
		$CollisionShape2D.set_deferred("disabled", true)

func reload():
	$Sprite2D.show()
	$CollisionShape2D.set_deferred("disabled", false)
