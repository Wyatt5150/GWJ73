extends AnimatedSprite2D

var queued : String = ""

func ChangeAnimation(animation : String):
	
	
	pass

func AnimationFinished():
	if len(queued) > 0:
		ChangeAnimation(queued)
		queued = ""
	pass
