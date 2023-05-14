extends Level

func _ready():
	fruits = 0

func reload():
	$Fruit2.reload()
	$Fruit3.reload()
	$Fruit4.reload()
	GamePlayProgress.fruits_collected -= fruits
	fruits = 0

func _on_area_2d_body_entered(body):
	body.position = $Area2D.position
	GamePlayProgress.current_level = self

