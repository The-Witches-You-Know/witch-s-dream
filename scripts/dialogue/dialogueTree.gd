class_name DialogueTree

static var dialogueTreeEntries = {
	"Test": [
		DialogueTreeEntry.monologue(
			"This is a test for the dialogue entry system. \nHere, you should be able to just click anywhere to proceed",1
		).addDefaultCallback(
			func (): SaveFile.setOrPut("DialogueTreeEntry.Test.NextOpeningLineIndex", 3)
		),
		DialogueTreeEntry.multiOption(
			"This is another entry for the system. Here, you should be able to see 3 options, one looping, one prompting to end dialogue, and one finishing dialogue instantly",
			[
				DialogueTreeOption.standardOption("Here we do a loop", 1),
				DialogueTreeOption.standardOption("Would you kindly finish dialogue?", 2).addCallback(
					func (): SaveFile.setOrPut("DialogueTreeEntry.Test.NextOpeningLineIndex", 4)
				),
				DialogueTreeOption.finishOption("Aight imma head out").addCallback(
					func (): SaveFile.setOrPut("DialogueTreeEntry.Test.ChoseOptionThree", true)
				),
				DialogueTreeOption.standardOption("Special finish dialogue by speaker, visible only to those who clicked option 3 at least once", 5).showOnCondition(
					func (): return SaveFile.safeGet("DialogueTreeEntry.Test.ChoseOptionThree", false)
				),
			]
		),
		DialogueTreeEntry.finish("Test dialogue tree, signing off. Have a nice day!"),
		DialogueTreeEntry.monologue("Here is a test for starting new dialogue for the same speaker. It will advance to the 3 options just like before.", 1).addDefaultCallback(
			func (): SaveFile.setOrPut("DialogueTreeEntry.Test.NextOpeningLineIndex", 3)
		),
		DialogueTreeEntry.monologue("Here is a special line for folks selecting option 2 in the multi-option dialogue tree entry. It will advance to the 3 options just like before and reset the starting line.", 1).addDefaultCallback(
			func (): SaveFile.setOrPut("DialogueTreeEntry.Test.NextOpeningLineIndex", 0)
		),
		DialogueTreeEntry.finish("Special finish dialogue triggered. Finishing dialogue..."),
		
	],
	"Deer":[
		DialogueTreeEntry.monologue( 
			"test" ,1
		).addDefaultCallback(
			func (): SaveFile.setOrPut("DialogueTreeEntry.Deer.NextOpeningLineIndex",1)
			
		),
		DialogueTreeEntry.finish("test succssfull"),
	]
	
}
