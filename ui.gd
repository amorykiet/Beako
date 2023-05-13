extends CanvasLayer

func _process(delta):
	%FruitsCollectedLabel.text = str(GamePlayProgress.fruits_collected)
	%FruitsCollectingLabel.text = str(GamePlayProgress.fruits_collecting)
	%State.text = str(GamePlayProgress.state.name)
	%Stama.text = str(GamePlayProgress.stama)
	%Collision.text = GamePlayProgress.collision
