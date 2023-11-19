extends CanvasGroup

var currentDialogueTree = null
var currentDialogueTreeEntry = null
var isPrintingOutText = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.			
		
# When starting dialogue, pick out correct dialogue tree and start at correct line
func openDialogueBox(dialogueTreeName, openingLineIndex):
	self.visible = true
	self.currentDialogueTree = DialogueTree.dialogueTreeEntries[dialogueTreeName]
	self.currentDialogueTreeEntry = currentDialogueTree[openingLineIndex]
	unfurlText()
	
# clear out the dialogue from the box and hide it
func hideDialogueBox():
	self.currentDialogueTree = null
	self.currentDialogueTreeEntry = null
	unfurlText()
	self.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if is_visible():
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if isPrintingOutText:
				printOutText()
				onTextFullyPrintedOut()
			else:
				if len (currentDialogueTreeEntry.dialogueOptions) > 0 :
					if (currentDialogueTreeEntry.dialogueOptions[0].dialogueLine != null):
						# check if player has clicked on any of the options
						pass
					else:
						currentDialogueTreeEntry = currentDialogueTree[currentDialogueTreeEntry.dialogueOptions[0].nextDialogueLineIndex]
				else:
					hideDialogueBox()

# trigger once text is fully inside the dialogue box		
func onTextFullyPrintedOut():
	if len (currentDialogueTreeEntry.dialogueOptions && currentDialogueTreeEntry.dialogueOptions[0].dialogueLine != null) > 0:
		createDialogueOptions()

# slowly unfurl the text
func unfurlText():
	pass

# create clickable boxes containing different dialogue options and place them on the screen in an aesthetic manner
# depending on the amount of options
func createDialogueOptions():
	pass
	
# stops slowly unfurling the text and prints it out completely
func printOutText():
	isPrintingOutText = false
		
