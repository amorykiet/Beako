extends Level

func _ready():
	fruits = 0

func reload():
	$Fruit2.reload()
	GamePlayProgress.fruits_collected -= fruits
	fruits = 0

func _on_area_2d_body_entered(body):
	GamePlayProgress.current_level = self
