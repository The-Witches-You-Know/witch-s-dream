extends Interactable

func onInteraction(player):
	player.startDialogue("Deer", self)
	
func afterDialogue(player):
	if SaveFile.safeGet("Player.Patron", "") == "Fey" && SaveFile.safeGet("DeerDialogueOptionPicked", -1) == 3:
		startWalking()
		
func startWalking():
	pass
