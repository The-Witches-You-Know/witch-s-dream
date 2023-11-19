class_name DialogueTree

static var dialogueTreeEntries = {
	"Test": [
		DialogueTreeEntry.monologue(
			"This is a test for the dialogue entry system. \nHere, you should be able to just click anywhere to proceed",1
		).addCallback(
			func (player): player.setSavefileData("DialogueTreeEntry.Test.NextOpeningLineIndex", 3)
		),
		DialogueTreeEntry.multiOption(
			"This is another entry for the system. Here, you should be able to see 3 options, \n
			1 of them looping, \n
			1 of them prompting the speaker to end dialogue, and \n
			1 of them finishing the dialogue instantly",
			[
				DialogueTreeOption.standardOption("Here we do a loop", 1),
				DialogueTreeOption.standardOption("Would you kindly finish dialogue?", 2).addCallback(
					func (player): player.setSavefileData("DialogueTreeEntry.Test.NextOpeningLineIndex", 4)
				),
				DialogueTreeOption.finishOption("Aight imma head out").addCallback(
					func (player): player.setSavefileData("DialogueTreeEntry.Test.ChoseOptionThree", true)
				),
				DialogueTreeOption.standardOption("Special finish dialogue by speaker, visible only to those who clicked option 3 at least once", 5).showOnCondition(
					func (player): player.getSavefileData("DialogueTreeEntry.Test.ChoseOptionThree") == 'true'
				),
			]
		),
		DialogueTreeEntry.finish("Test dialogue tree, signing off. Have a nice day!"),
		DialogueTreeEntry.monologue("Here is a test for starting new dialogue for the same speaker. \n it will advance to the 3 options just like before.", 1).addCallback(
			func (player): player.setSavefileData("DialogueTreeEntry.Test.NextOpeningLineIndex", 3)
		),
		DialogueTreeEntry.monologue("Here is a special line for folks selecting option 2 in the multi-option dialogue tree entry. \n it will advance to the 3 options just like before.", 1).addCallback(
			func (player): player.setSavefileData("DialogueTreeEntry.Test.NextOpeningLineIndex", 3)
		),
		DialogueTreeEntry.finish("Special finish dialogue triggered. Finishing dialogue..."),
		
	]
}
