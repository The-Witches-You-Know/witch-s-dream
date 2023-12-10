extends CanvasGroup
class_name DialogueHandler

var currentDialogueTree = null
var currentDialogueTreeEntry = null
var isPrintingOutText = false
@onready var dialogueOptions = [$DialogueOption1, $DialogueOption2, $DialogueOption3, $DialogueOption4]
@onready var speakerSprite = $SpeakerSprite
@onready var speakerNameLabel = $MainTextPanel/SpeakerNameLabel
@onready var mainTextLabel = $MainTextPanel/MainTextLabel

var justOpened: bool = false

var expectedDialogueOptionsPositions = [
	[],
	[Vector2(-300, -80)],
	[Vector2(-300, -140), Vector2(-300, -20)],
	[Vector2(-300,-170), Vector2(-300, -80), Vector2(-300, 10)],
	[Vector2(-300,-200), Vector2(-300, -120), Vector2(-300, -40), Vector2(-300, 40)]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	for option in dialogueOptions:
		option.visible = false
	#openDialogueBox("Test", SaveFile.safeGet("DialogueTreeEntry.Test.NextOpeningLineIndex", 0))
		
# When starting dialogue, pick out correct dialogue tree and start at correct line
func openDialogueBox(dialogueTreeName, openingLineIndex):
	if(self.visible):
		#cannot open new dialogue box if dialogue box already open
		return
	justOpened = true
	Cursor.show()
	speakerSprite.texture = ResourceLoader.load(DialogueTree.dialogueDefaultSpeakerSprites[dialogueTreeName])
	self.visible = true
	self.currentDialogueTree = DialogueTree.dialogueTreeEntries[dialogueTreeName]
	self.currentDialogueTreeEntry = currentDialogueTree[openingLineIndex]
	speakerNameLabel.text = dialogueTreeName
	mainTextLabel.text = ""
	unfurlText()
	
# clear out the dialogue from the box and hide it
func hideDialogueBox():
	Cursor.hide()
	self.currentDialogueTree = null
	self.currentDialogueTreeEntry = null
	unfurlText()
	self.visible = false

func _unhandled_input(event):
	if is_visible():
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			if (event.pressed and !justOpened):
				if isPrintingOutText:
					printOutText()
					onTextFullyPrintedOut()
				else:
					if len (currentDialogueTreeEntry.dialogueOptions) > 0 :
						if (currentDialogueTreeEntry.dialogueOptions[0].dialogueLine == null):
							onOptionSelection(0)
					else:
						hideDialogueBox()
			else:
				justOpened = false

# trigger once text is fully inside the dialogue box		
func onTextFullyPrintedOut():
	if len (currentDialogueTreeEntry.dialogueOptions && currentDialogueTreeEntry.dialogueOptions[0].dialogueLine != null) > 0:
		createDialogueOptions()

# slowly unfurl the text
func unfurlText():
	for option in dialogueOptions:
		option.visible = false
	mainTextLabel.text = "" if currentDialogueTreeEntry == null else currentDialogueTreeEntry.dialogueLine
	createDialogueOptions()

# create clickable boxes containing different dialogue options and place them on the screen in an aesthetic manner
# depending on the amount of options
func createDialogueOptions():
	if currentDialogueTreeEntry == null:
		return
	if len (currentDialogueTreeEntry.dialogueOptions) > 0 :
		if (currentDialogueTreeEntry.dialogueOptions[0].dialogueLine != null):
			for i in len(currentDialogueTreeEntry.dialogueOptions.filter(func (opt):
				if (opt.conditionForOptionVisibility != null):
					return opt.conditionForOptionVisibility.call()
				return true
				)):
				dialogueOptions[i].visible = true
				dialogueOptions[i].get_child(0).text = currentDialogueTreeEntry.dialogueOptions[i].dialogueLine
				dialogueOptions[i].position = expectedDialogueOptionsPositions[len(currentDialogueTreeEntry.dialogueOptions)][i]
		
	
# stops slowly unfurling the text and prints it out completely
func printOutText():
	isPrintingOutText = false
		

func _on_dialogue_option_1_pressed():
	onOptionSelection(0)

func _on_dialogue_option_2_pressed():
	onOptionSelection(1)

func _on_dialogue_option_3_pressed():
	onOptionSelection(2)

func _on_dialogue_option_4_pressed():
	onOptionSelection(3)
	
func onOptionSelection(optionIndex):
	if (justOpened):
		justOpened = false
		return
	if (currentDialogueTreeEntry.dialogueOptions[optionIndex].selectionCallback != null):
		currentDialogueTreeEntry.dialogueOptions[optionIndex].selectionCallback.call(self)
	var nextIndex = currentDialogueTreeEntry.dialogueOptions[optionIndex].nextDialogueLineIndex
	if (nextIndex == null):
		hideDialogueBox()
	else:		
		currentDialogueTreeEntry = currentDialogueTree[nextIndex]
		unfurlText()
