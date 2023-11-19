extends Interactable

func onInteraction(player):
	player.startDialogue("Deer", self)
	
func afterDialogue(player):
	if SaveFile.safeGet("FeyAligned") && SaveFile.safeGet("DeerDialogueOptionPicked") == 3:
		startWalking()
		
func startWalking():
	pass
