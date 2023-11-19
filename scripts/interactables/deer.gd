extends Interactable

func onInteraction(player):
	player.startDialogue("Deer", self)
	
func afterDialogue(player):
	if player.getSavefileData("FeyAligned") == 'true' && player.getSavefileData("DeerDialogueOptionPicked") == '3':
		startWalking()
		
func startWalking():
	pass
