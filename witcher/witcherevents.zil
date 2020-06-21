;----------------------
"Override"

<SET REDEFINE T>

<ROUTINE LINE-ERASE (ROW)
	<CURSET .ROW 1>
	<DO (I <LOWCORE SCRH> 1 -1) <PRINTC !\ >>
	<CURSET .ROW 1>>

<ROUTINE UPDATE-STATUS-LINE ("AUX" WIDTH)
	<SPLIT 2>
	<SCREEN 1>
	<SET WIDTH <LOWCORE SCRH>>
	<HLIGHT ,H-INVERSE>
	<LINE-ERASE 1>
	<TELL !\ >
	<COND (,HERE-LIT <TELL D ,HERE>)(ELSE <TELL %,DARKNESS-STATUS-TEXT>)>
	<TELL " - " <COND (,DAYTIME "Day")(ELSE "Night")>>
	<CURSET 1 <- .WIDTH 30>>
	<TELL "Health: " N ,WITCHER-HEALTH>
	<CURSET 1 <- .WIDTH 15>>
	<TELL "Food: " N ,WITCHER-FOOD>
	<LINE-ERASE 2>
	<TELL !\ >
	<COND (,RIDING-VEHICLE <TELL "(Riding " D ,CURRENT-VEHICLE ")">)(<IN? ,ROACH ,HERE> <TELL "(" D ,ROACH " is here)">)>
	<CURSET 2 <- .WIDTH 29>>
	<TELL "Score: " N ,SCORE>
	<CURSET 2 <- .WIDTH 16>>
	<TELL "Moves: " N ,MOVES>
	<SCREEN 0>
	<HLIGHT 0>>

;----------------------
"Death Routines"

<ROUTINE DEATH-COMBAT ()
	<CRLF>
	<JIGS-UP "In all your years killing monsters, you have not found something you could not overcome until today.">>

<ROUTINE DEATH-HEALTH ()
	<CRLF>
	<JIGS-UP "In all your years killing monsters, you never expected that you could die from poor health." >>

;----------------------
"World Cycles"

<ROUTINE I-DAYNIGHT-CYCLE ()
	<SETG DAYTIME <NOT ,DAYTIME>>
	<HLIGHT ,H-BOLD>
	<COND (,DAYTIME
		<TELL "[Night turns to day]">
	)(ELSE
		<TELL "[Day turns to night]">
	)>
	<HLIGHT 0>
	<CRLF>
	<START-DAY-NIGHT-CYCLE>>

<ROUTINE START-DAY-NIGHT-CYCLE ()
	<QUEUE I-DAYNIGHT-CYCLE <+ DAY-LENGTH 1>>>

<ROUTINE I-OIL-IN-STEEL-DEPLETES ()
	<COND (<FIRST? ,STEEL-SWORD> <HLIGHT ,H-BOLD> <TELL "[" T <FIRST? STEEL-SWORD> " wears off]" CR> <CLEAN-SWORD ,STEEL-SWORD T> <HLIGHT 0>)>>

<ROUTINE I-OIL-IN-SILVER-DEPLETES ()
	<COND (<FIRST? ,SILVER-SWORD> <HLIGHT ,H-BOLD> <TELL "[" T <FIRST? SILVER-SWORD> " wears off]" CR> <CLEAN-SWORD ,SILVER-SWORD T> <HLIGHT 0>)>>

;----------------------
"Witcher actions"

<ROUTINE APPLY-OIL (OIL SWORD)
	<TELL "You apply " T .OIL " onto " T .SWORD CR>
	<COND(<EQUAL? .SWORD ,SILVER-SWORD>
		<DEQUEUE I-OIL-IN-SILVER-DEPLETES>
		<QUEUE I-OIL-IN-SILVER-DEPLETES WITCHER-OIL-DURATION>
	)(<EQUAL? .SWORD ,STEEL-SWORD>
		<DEQUEUE I-OIL-IN-STEEL-DEPLETES>
		<QUEUE I-OIL-IN-STEEL-DEPLETES WITCHER-OIL-DURATION>
	)>>

<ROUTINE CANNOT-APPLY-OIL (OIL SWORD)
	<TELL "You cannot apply " T .OIL " to " T .SWORD ", or if you can, it will not be effective." CR>>

<ROUTINE CHECK-INVESTIGATION (BOUNTY CLUE-TABLE CONCLUSION PERSON)
	<COND (<AND <NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>> <NOT <GETP .BOUNTY ,P?BOUNTY-REPORTED>>>
		<COND (<CHECK-IF-BOUNTY-INVESTIGATED .CLUE-TABLE>
			<CRLF>
			<HLIGHT ,H-BOLD>
			<TELL .CONCLUSION D .PERSON ".">
			<HLIGHT 0>
			<CRLF>
			<PUTP .BOUNTY ,P?BOUNTY-INVESTIGATED T>
		)>
	)>>

<ROUTINE CHECK-SWORD-DMG (SWORD)
	<TELL ", deals " N <GETP .SWORD ,P?HIT-DAMAGE> " damage.">>

<ROUTINE CHECK-SWORD-OIL (SWORD)
	<COND (<FIRST? .SWORD>
		<TELL "with applied " D <FIRST? .SWORD>>
	)(ELSE
		<TELL "with no oils applied">
	)>>

<ROUTINE CLEAN-SWORD(SWORD "OPT" SILENT)
	<COND (<EQUAL? .SWORD ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<FIRST? .SWORD>
			<COND (<NOT .SILENT> <TELL "You remove " T <FIRST? .SWORD> " from the " T .SWORD CR>)>
			<MOVE <FIRST? .SWORD> ,PLAYER>
		)(ELSE
			<COND (<NOT .SILENT> <TELL CT .SWORD " is quite clean." CR>)>
		)>
	)(ELSE
		<COND (<NOT .SILENT> <NOTHING-HAPPENS>)>
	)>>

<ROUTINE INVESTIGATE-CLUE (CLUE CLUE-TABLE CLUE-NUM "OPT" (TOUCH FALSE))
    <COND (<EQUAL? ,PRSO .CLUE>
		<PUT .CLUE-TABLE .CLUE-NUM T>
		<COND (.TOUCH <FSET .CLUE ,TOUCHBIT>)>
	)>>

<ROUTINE REMOVE-AND-APPLY (OIL SWORD)
	<COND (<FIRST? .SWORD>
		<MOVE <FIRST? .SWORD> ,PLAYER>
	)>
	<MOVE .OIL .SWORD>
	<APPLY-OIL .OIL .SWORD>>

<ROUTINE WITCHER-EAT ()
	<CRLF>
	<COND (<G? ,WITCHER-FOOD 0>
		<TELL "[... Feeling hungry, you decide to eat some food from your supplies.]" CR>
		<SETG WITCHER-FOOD <- ,WITCHER-FOOD WITCHER-CONSUMPTION>>
		<WITCHER-HEAL WITCHER-HEALING-RATE>
	)(ELSE
		<TELL "[... Feeling hungry, you decide to eat but you find that you do not have any food from your supplies.]" CR>
	)>>

<ROUTINE WITCHER-GATHER-FOOD (AMT)
	<TELL "... you found " N .AMT " pieces of food for your supply." CR>
	<SETG WITCHER-FOOD <+ ,WITCHER-FOOD .AMT>>>

;----------------------
"Combat Routines"

<ROUTINE CHOOSE-WEAPON (MONSTER "AUX" KEY)
	<REPEAT ()
		<CRLF>
		<TELL "Choose weapon to fight " T .MONSTER " with:" CR>
		<COND (<IN? ,SILVER-SWORD ,PLAYER> <TELL "1 - " T ,SILVER-SWORD CR>)>
		<COND (<IN? ,STEEL-SWORD ,PLAYER> <TELL "2 - " T ,STEEL-SWORD CR>)>
		<TELL "3 - None. My witcher powers are enough." CR>
		<SET .KEY <INPUT 1>>
		<COND (<AND <EQUAL? .KEY !\1> <IN? ,SILVER-SWORD ,PLAYER>> <RETURN ,SILVER-SWORD>)>
		<COND (<AND <EQUAL? .KEY !\2> <IN? ,STEEL-SWORD ,PLAYER>> <RETURN ,STEEL-SWORD>)>
		<COND (<EQUAL? .KEY !\3> <RETURN NONE>)>
	>>

<ROUTINE COMBAT-SILVER (MONSTER WEAPON "OPT" OIL)
	<COMBAT-SWORD .MONSTER .WEAPON ,SILVER-SWORD .OIL>>

<ROUTINE COMBAT-STEEL (MONSTER WEAPON "OPT" OIL)
	<COMBAT-SWORD .MONSTER .WEAPON ,STEEL-SWORD .OIL>>

<ROUTINE COMBAT-SWORD (MONSTER WEAPON SWORDTYPE "OPT" OIL)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<NOT .WEAPON>
		<TELL "Not using any weapon isn't going to help you in this situation." CR>
		<MONSTER-ATTACKS .MONSTER>
	)(ELSE
		<COND (<FSET? .WEAPON ,WEAPONBIT>
			<COND (<EQUAL? .WEAPON .SWORDTYPE>
				<WITCHER-ATTACK .MONSTER .WEAPON .OIL>
				<MONSTER-ATTACKS .MONSTER>
			)(ELSE
				<WEAPON-INEFFECTIVE .MONSTER .WEAPON>
				<MONSTER-ATTACKS .MONSTER>
			)>
		)(ELSE
			<NO-COMBAT-PLAN .MONSTER .WEAPON>
			<MONSTER-ATTACKS .MONSTER>
		)>
	)>
	<RTRUE>>

<ROUTINE COMPLETE-IF-BOUNTY (MONSTER LOC "AUX" BOUNTY BOUNTY-MONSTER)
	<SET BOUNTY <GETP .LOC ,P?BOUNTY>>
	<COND (.BOUNTY
		<SET BOUNTY-MONSTER <GETP .BOUNTY ,P?BOUNTY-MONSTER>>
		<COND (<EQUAL? .MONSTER .BOUNTY-MONSTER>
			<PUTP .BOUNTY ,P?BOUNTY-COMPLETED T>
			<SETG SCORE <+ ,SCORE <GETP .BOUNTY ,P?VALUE>>>
		)>
	)>>

<ROUTINE MONSTER-ACTION (MONSTER HP SWORD WEAPON "OPT" OIL)
	<COND (<VERB? ATTACK>
		<COND(<EQUAL? .SWORD ,SILVER-SWORD>
			<COMBAT-SILVER .MONSTER .WEAPON .OIL>
		)(ELSE
			<COMBAT-STEEL .MONSTER .WEAPON .OIL>
		)>
	)(<VERB? LOOK-CLOSELY EXAMINE>
		<COND(<L? <GETP .MONSTER P?HIT-POINTS> .HP>
			<TELL "... " T .MONSTER " appears wounded." CR>
		)>
	)>>

<ROUTINE MONSTER-ATTACKS (MONSTER "AUX" DMG)
	<COND (<OR <LOC .MONSTER> <G? .MONSTER 0>>
		<COND (<G? <GETP .MONSTER P?HIT-POINTS> 0>
			<TELL CT .MONSTER " attacks!" CR>
			<COND (<L? <RANDOM 100> ,WITCHER-DODGE-PROBABILITY>
				<TELL "... you manage to dodge its attack!" CR>
			)(ELSE
				<SET DMG <GETP .MONSTER P?HIT-DAMAGE>>
				<COND (<NOT ,DAYTIME>
					<TELL "... the night makes " T .MONSTER " more powerful!" CR>
					<SET DMG <* .DMG 2>>
				)>
				<WITCHER-COMBAT-DAMAGE .DMG>
			)>
		)>
	)>>

<ROUTINE NO-COMBAT-PLAN (MONSTER WEAPON)
	<TELL "That is your plan? Attacking " T .MONSTER " with " T .WEAPON "?" CR>>

<ROUTINE WEAPON-INEFFECTIVE (MONSTER SWORD "AUX" DMG)
	<SET DMG <GETP .SWORD P?LOW-DAMAGE>>
	<TELL "Your " D .SWORD " hits " T .MONSTER " with a dull sound." CR>
	<TELL "... " CT .MONSTER " suffers " N .DMG " points of damage." CR>
	<PUTP .MONSTER P?HIT-POINTS <- <GETP .MONSTER P?HIT-POINTS> .DMG>>
	<COND (<L? <GETP .MONSTER P?HIT-POINTS> 1>
		<TELL "... but the blow was fatal. " CT .MONSTER>
		<COND (<FSET? .MONSTER ,PLURALBIT>
			<TELL " die.">
		)(ELSE
			<TELL " dies.">
		)>
		<CRLF>
		<REMOVE .MONSTER>
		<COMPLETE-IF-BOUNTY .MONSTER ,HERE>
		<RETURN>
	)>
	<TELL "... Your " D .SWORD " is not effective against " T .MONSTER "!" CR CR>>

<ROUTINE WITCHER-ATTACK (MONSTER SWORD "OPT" OIL "AUX" DMG)
	<SET DMG <GETP .SWORD P?HIT-DAMAGE>>
	<COND (<AND .OIL <IN? .OIL .SWORD>>
		<SET DMG <+ .DMG <GETP .OIL P?BONUS-DAMAGE>>>
	)>
	<TELL "You " <PICK-ONE ATTACK-DESCRIPTIONS> " " T .MONSTER " with your " D .SWORD " for " N .DMG " points of damage." CR>
	<PUTP .MONSTER P?HIT-POINTS <- <GETP .MONSTER P?HIT-POINTS> .DMG>>
	<COND (<L? <GETP .MONSTER P?HIT-POINTS> 1>
		<TELL "... you deal a fatal blow. " CT .MONSTER>
		<COND (<FSET? .MONSTER ,PLURALBIT>
			<TELL " die.">
		)(ELSE
			<TELL " dies.">
		)>
		<CRLF>
		<REMOVE .MONSTER>
		<COMPLETE-IF-BOUNTY .MONSTER ,HERE>
		<RETURN>
	)>
	<CRLF>>

<ROUTINE WITCHER-COMBAT-DAMAGE (AMT)
	<TELL "... you took " N .AMT " points of damage." CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-COMBAT>
	)>>

<ROUTINE WITCHER-HEAL (AMT)
	<COND (<L? ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
		<TELL "... you heal " N .AMT " points." CR>
	)>
	<SETG WITCHER-HEALTH <+ ,WITCHER-HEALTH .AMT>>
	<COND (<G? ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
		<SETG WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
	)>>

<ROUTINE WITCHER-HEALTH-DAMAGE (AMT REASON)
	<TELL "... " .REASON " hits you for " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-HEALTH>
	)>>

;----------------------
"NPC Actions / Dialog"

<ROUTINE ACCEPT-BOUNTY (BOUNTY PERSON "AUX" LOC)
	<COND (<FSET? .BOUNTY ,BOUNTYBIT>
		<SET LOC <GETP .BOUNTY P?BOUNTY-LOC>>
		<COND (<NOT <GETP .BOUNTY P?BOUNTY-ACCEPTED>>
			<TELL "Accept this bounty (" T .BOUNTY ")? ">
			<COND (<YES?>
				<PUTP .BOUNTY P?BOUNTY-ACCEPTED T>
				<CRLF>
				<COND (.LOC
					<TALK-HIGHLIGHT-PERSON .PERSON "Splendid! You should investigate ">
					<TELL T .LOC " area for clues.">
				)(ELSE
					<TALK-HIGHLIGHT-PERSON .PERSON "Splendind! You should look for clues around the area.">
				)>
			)(ELSE
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .PERSON "That is unfortunate. Let me know if you change your mind.">
			)>
			<CRLF>
		)>
	)(ELSE
		<TELL "The what now?" CR>
		<RFALSE>
	)>>

<ROUTINE CHECK-BOUNTY (BOUNTY THISBOUNTY PERSON)
	<COND (.THISBOUNTY
		<COND (<FSET? .THISBOUNTY ,BOUNTYBIT>
			<COND (<NOT <EQUAL? .THISBOUNTY .BOUNTY>>
				<TELL D .PERSON " does not know anything about " T .THISBOUNTY CR>
				<RFALSE>
			)>
			<RTRUE>
		)>
		<TALK-HIGHLIGHT-PERSON .PERSON "The what now?">
		<CRLF>
		<RFALSE>
	)>
	<RTRUE>>

<ROUTINE GENERIC-BOUNTY-DIALOG (PERSON BOUNTY REPORT)
	<COND (<NOT <GETP .BOUNTY P?BOUNTY-INVESTIGATED>>
		<TALK-HIGHLIGHT-PERSON .PERSON "You should probably continue investigating ">
		<TELL T <GETP .BOUNTY P?BOUNTY-LOC> " area." CR>
	)(ELSE
		<COND (<NOT <GETP .BOUNTY P?BOUNTY-REPORTED>>
			<TALK-HIGHLIGHT-PERSON .PERSON .REPORT>
			<PUTP .BOUNTY ,P?BOUNTY-REPORTED T>
		)(ELSE
			<COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
				<TALK-HIGHLIGHT-PERSON .PERSON "Please come back after you have dealt with the beast for your reward.">
			)(ELSE
				<TALK-HIGHLIGHT-PERSON .PERSON "Thanks, witcher! Our town is safe again!">
				<COND (<G? <GETP .BOUNTY ,P?BOUNTY-REWARD> 0>
					<SETG ,WITCHER-ORENS <+ ,WITCHER-ORENS <GETP .BOUNTY ,P?BOUNTY-REWARD>>>
					<TELL " Here is your reward. (" N <GETP .BOUNTY ,P?BOUNTY-REWARD> " Orens)">
					<PUTP .BOUNTY ,P?BOUNTY-REWARD 0>
				)>
			)>
		)>
		<CRLF>
	)>>

<ROUTINE GENERIC-BOUNTY-TALK (BOUNTY PERSON TEXT REPORT "AUX" KEY)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<VERB? TALK>
		<CRLF>
		<COND (<NOT <EQUAL? ,PRSO .PERSON>>
			<TALK-HIGHLIGHT-PERSON .PERSON "You talking to me?">
			<CRLF>
			<RTRUE>
		)>
		<COND (<IN? .BOUNTY ,PLAYER>
			<COND (<GETP .BOUNTY P?BOUNTY-ACCEPTED>
				<COND (<NOT <CHECK-BOUNTY .BOUNTY ,PRSI ,PRSO>>
					<RETURN>
				)>
				<GENERIC-BOUNTY-DIALOG .PERSON .BOUNTY .REPORT>
			)(ELSE
				<COND (<NOT <CHECK-BOUNTY .BOUNTY ,PRSI ,PRSO>>
					<RETURN>
				)>
				<REPEAT ()
					<TALK-HIGHLIGHT-PERSON .PERSON "">
					<CRLF>
					<TELL "Are you here about the bounty (" D .BOUNTY ")?" CR>
					<TELL "1 - Yes, tell me more about this." CR>
					<TELL "2 - I accept the bounty." CR>
					<TELL "3 - Goodbye for now." CR>
					<TELL "Your response: ">
					<SET KEY <INPUT 1>>
					<CRLF>
					<TALK-RESPONSE .KEY !\1 .TEXT ,PRSO>
					<COND (<EQUAL? .KEY !\2>
						<ACCEPT-BOUNTY .BOUNTY ,PRSO>
						<RETURN>
					)(<EQUAL? .KEY !\3>
						<CRLF>
						<TALK-HIGHLIGHT-PERSON .PERSON "Bye!">
						<CRLF>
						<RTRUE>
					)>
					<CRLF>
					<CLOCKER>
					<UPDATE-STATUS-LINE>
				>
			)>
		)(ELSE
			<TALK-HIGHLIGHT-PERSON .PERSON "Greetings!">
			<CRLF>
		)>
	)(<VERB? EXAMINE LOOK-CLOSELY>
		<TELL "In most cultures it is rude to stare." CR>
	)>>

<ROUTINE GENERIC-MERCHANT (MERCHANT WARES PRICELIST "AUX" ITEM ITEMS KEY)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<OR <NOT .WARES> <NOT .PRICELIST> <NOT .MERCHANT>> <RETURN>)>
	<SET ITEMS <GET .WARES 0>>
	<REPEAT ()
		<CRLF>
		<TALK-HIGHLIGHT-PERSON .MERCHANT "Greetings, Witcher! Can I interest you in:">
		<CRLF>
		<DO (I 1 .ITEMS)
			<TELL N .I " - " D <GET .WARES .I> " (" N <GET .PRICELIST .I> " Orens)" CR>
		>
		<TELL N <+ .ITEMS 1> " - No thanks" CR>
		<TELL "You are carrying " N ,WITCHER-ORENS " Orens: ">
		<SET KEY <INPUT 1>>
		<CRLF>
		<COND (<AND <G? .KEY 48> <L? .KEY <+ .ITEMS 49>>>
			<SET ITEM <- .KEY 48>>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .MERCHANT "Purchase ">
			<TELL D <GET .WARES .ITEM> " (" N <GET .PRICELIST .ITEM> " Orens)? ">
			<COND (<YES?>
				<COND (<L? ,WITCHER-ORENS <GET .PRICELIST .ITEM>>
					<TELL "You can't afford " T <GET .WARES .ITEM> "!" CR>
				)(ELSE
					<COND (<FSET? <GET .WARES .ITEM> ,TAKEBIT>
						<COND (<IN? <GET .WARES .ITEM> ,PLAYER>
							<TELL "You already have " T <GET .WARES .ITEM> "!" CR>
						)(ELSE
							<SETG ,WITCHER-ORENS <- ,WITCHER-ORENS <GET .PRICELIST .ITEM>>>
							<TELL "You bought " T <GET .WARES .ITEM> CR>
							<MOVE <GET .WARES .ITEM> ,PLAYER>
						)>
					)(T
						<SETG ,WITCHER-ORENS <- ,WITCHER-ORENS <GET .PRICELIST .ITEM>>>
						<TELL "You bought " T <GET .WARES .ITEM> CR>
						<COND (<EQUAL? <GET .WARES .ITEM> ,DUMMY-FOOD> <SETG ,WITCHER-FOOD <+ ,WITCHER-FOOD 1>>)>
						<COND (<EQUAL? <GET .WARES .ITEM> ,DUMMY-BOMB> <SETG ,WITCHER-BOMBS <+ ,WITCHER-BOMBS 1>>)>
					)>
				)>
			)>
		)>
		<COND (<EQUAL? .KEY <+ .ITEMS 49>>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .MERCHANT "Bye!">
			<CRLF>
			<RTRUE>
		)>
		<UPDATE-STATUS-LINE>
	>>

<ROUTINE GENERIC-SMITH (SMITH ENHANCEMENTS PRICELIST "AUX" ITEM KEY PRICE DMG)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<REPEAT ()
		<CRLF>
		<TALK-HIGHLIGHT-PERSON .SMITH "Greetings, Witcher! Can I help you with:">
		<CRLF>
		<TELL "1 - enhancing your " D ,SILVER-SWORD " (+" N <GET .ENHANCEMENTS 1> " damage, " N <GET .PRICELIST 1> " Orens)" CR>
		<TELL "2 - enhancing your " D ,STEEL-SWORD " (+" N <GET .ENHANCEMENTS 2> " damage, " N <GET .PRICELIST 2> " Orens)" CR>
		<TELL "3 - No thanks." CR>
		<TELL "You are carrying " N ,WITCHER-ORENS " Orens: ">
		<SET KEY <INPUT 1>>
		<CRLF>
		<COND (<EQUAL? .KEY !\1 !\2>
			<CRLF>
			<SET ITEM <- .KEY 48>>
			<SET PRICE <GET .PRICELIST .ITEM>>
			<SET DMG <GET .ENHANCEMENTS .ITEM>>
			<TELL "Purchase this enhancement (+" N .DMG " damage, " N .PRICE " Orens)? ">
			<COND (<YES?>
				<CRLF>
				<COND (<L? ,WITCHER-ORENS .PRICE>
					<TELL "You cannot afford this!" CR>
				)(ELSE
					<COND (<EQUAL? .ITEM 1>
						<COND (<NOT <IN? ,SILVER-SWORD ,PLAYER>>
							<TELL "You do not have your " D ,SILVER-SWORD " with you!">
						)(T
							<SETG ,WITCHER-ORENS <- ,WITCHER-ORENS .PRICE>>
							<TELL "You bought this enhancement (+" N .DMG " damage for your " D ,SILVER-SWORD>
							<PUTP ,SILVER-SWORD ,P?HIT-DAMAGE <+ <GETP ,SILVER-SWORD P?HIT-DAMAGE> .DMG>>
						)>
					)(T
						<COND (<NOT <IN? ,STEEL-SWORD ,PLAYER>>
							<TELL "You do not have your " D ,STEEL-SWORD " with you!">
						)(T
							<SETG ,WITCHER-ORENS <- ,WITCHER-ORENS .PRICE>>
							<TELL "You bought this enhancement (+" N .DMG " damage for your " D ,STEEL-SWORD>
							<PUTP ,STEEL-SWORD ,P?HIT-DAMAGE <+ <GETP STEEL-SWORD P?HIT-DAMAGE> .DMG>>
						)>
					)>
					<CRLF>
				)>
			)>
		)>
		<COND (<EQUAL? .KEY !\3>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .SMITH "Bye!">
			<CRLF>
			<RTRUE>
		)>
	>>

<ROUTINE TALK-HIGHLIGHT-PERSON (PERSON TEXT)
	<HLIGHT ,H-BOLD>
	<TELL D .PERSON>
	<HLIGHT 0>
	<TELL ": " .TEXT>>

<ROUTINE TALK-RESPONSE (KEY CHOICE RESPONSE PERSON)
	<COND (<EQUAL? .KEY .CHOICE>
		<CRLF>
		<TALK-HIGHLIGHT-PERSON .PERSON .RESPONSE>
		<CRLF>
		<INPUT 1>
	)>>

;----------------------
"Codex Routines"

<ROUTINE PRINT-TOPIC (TOPIC)
	<CRLF>
	<HLIGHT ,H-INVERSE>
	<TELL "Topic: " D .TOPIC CR CR>
	<HLIGHT 0>
	<TELL <GETP .TOPIC P?LDESC> CR>>

;----------------------
"Location setup"

<ROUTINE CHECK-FOOD-AVAILABILITY ()
	<COND (<FSET? ,HERE ,HASFOOD>
		<TELL "[... you can probably get some food here.]" CR>
	)>>

<ROUTINE CHECK-TRAVEL-FATIGUE ()
	<COND (<NOT ,RIDING-VEHICLE>
		<TELL "A long time passed before you arrived." CR CR>
		<TIME-PASSES WITCHER-TRAVEL-TIME>
	)(ELSE
		<MOVE ,CURRENT-VEHICLE ,HERE>
	)>>

<ROUTINE DESCRIBE-LOCATION (LOC)
	<TELL <GETP .LOC ,P?LDESC> CR>>

<ROUTINE IS-VISIBLE (LOC DIR "AUX" WHERE INV)
	<SET WHERE <GETP .LOC .DIR>>
	<COND (<NOT .WHERE> <RETURN FALSE>)>
	<SET INV <FSET? .WHERE ,INVISIBLE>>
	<RETURN <AND .WHERE <NOT .INV>>>>

<ROUTINE DESCRIBE-EXITS (LOC)
	<COND (<NOT .LOC> <RETURN>)>
	<CRLF>
	<HLIGHT ,H-BOLD>
	<TELL "Exits">
	<HLIGHT 0>
	<CRLF>
	<COND (<IS-VISIBLE .LOC ,P?NW> <TELL "Northwest: " D <GETP .LOC ,P?NW> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?NORTH> <TELL "North: " D <GETP .LOC ,P?NORTH> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?NE> <TELL "Northeast: " D <GETP .LOC ,P?NE> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?WEST> <TELL "West: " D <GETP .LOC ,P?WEST> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?EAST> <TELL "East: " D <GETP .LOC ,P?EAST> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?SW> <TELL "Southwest: " D <GETP .LOC ,P?SW> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?SOUTH> <TELL "South: " D <GETP .LOC ,P?SOUTH> CR>)>
	<COND (<IS-VISIBLE .LOC ,P?SE> <TELL "Southeast: " D <GETP .LOC ,P?SE> CR>)>
	<RTRUE>>

<ROUTINE SEARCH-LOCATION (LOC "AUX" CURRENTOBJ)
	<COND (<AND <FSET? ,WOLF-MEDALLION ,WEARBIT> <FSET? ,WOLF-MEDALLION ,WORNBIT>>
		<SET CURRENTOBJ <FIRST? .LOC>>
		<REPEAT ()
			<COND (<NOT .CURRENTOBJ>
				<RETURN>
			)(ELSE 
				<COND (<FSET? .CURRENTOBJ ,MAGICBIT>
					<TELL CR "[Your medallion senses the presence of ">
					<HLIGHT ,H-INVERSE>
					<TELL T .CURRENTOBJ>
					<HLIGHT 0>
					<TELL " here.]" CR>
				)>
			)>
			<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
		>
	)>>

;----------------------
"Monster / Bounty Setup"

<ROUTINE ADD-BOUNTY (BOUNTY LOC)
	<COND (<EQUAL? .LOC <GETP .BOUNTY ,P?BOUNTY-LOC>>
		<COND (<GETP .BOUNTY ,P?BOUNTY-REPORTED>
			<COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
				<COND (<NOT <IN? <GETP .BOUNTY ,P?BOUNTY-MONSTER> .LOC>>
					<COND (<EQUAL? <GETP .BOUNTY ,P?BOUNTY-MONSTER> ,GRIFFIN> <RESET-MONSTER ,GRIFFIN ,HP-GRIFFIN .LOC>)>
					<COND (<EQUAL? <GETP .BOUNTY ,P?BOUNTY-MONSTER> ,ALGHOUL> <RESET-MONSTER ,ALGHOUL ,HP-ALGHOUL .LOC>)>
				)>
			)>
		)>
	)>>

<ROUTINE ADD-CLUES (BOUNTY LOC)
	<COND (<EQUAL? .LOC ,CROSSROADS>
		<POPULATE-CLUES-IN-LOC .LOC .BOUNTY WHITE-ORCHARD-CLUES>
	)(<EQUAL? .LOC ,WHITE-ORCHARD-FARM>
		<POPULATE-CLUES-IN-LOC .LOC .BOUNTY FARM-CLUES>
	)>>

<ROUTINE CHECK-IF-BOUNTY-INVESTIGATED (CLUE-TABLE "AUX" CLUES CLUES-INVESTIGATED)
	<SET CLUES <GET .CLUE-TABLE 0>>
	<SET CLUES-INVESTIGATED 0>
	<DO (I 1 .CLUES)
		<COND (<GET .CLUE-TABLE .I>
			<SET CLUES-INVESTIGATED <+ .CLUES-INVESTIGATED 1>>
		)>
	>
	<COND (<EQUAL? .CLUES .CLUES-INVESTIGATED>
		<RTRUE>
	)>
	<RFALSE>>

<ROUTINE POPULATE-CLUES-IN-LOC (LOC BOUNTY CLUE-TABLE "AUX" CLUES)
	<COND (<AND <GETP .BOUNTY ,P?BOUNTY-ACCEPTED> <NOT <GETP .BOUNTY ,P?BOUNTY-INVESTIGATED>> <NOT <GETP .BOUNTY ,P?BOUNTY-REPORTED>>>
		<SET CLUES <GET .CLUE-TABLE 0>>
		<DO (I 1 .CLUES)
			<MOVE <GET .CLUE-TABLE .I> .LOC>
		>
	)>>

<ROUTINE RESET-MONSTER (MONSTER HP LOC)	
	<PUTP .MONSTER P?HIT-POINTS .HP>
	<MOVE .MONSTER .LOC>>

<ROUTINE SETUP-BOUNTY (BOUNTY "AUX" LOC ACT INV RPT COMP)
	<COND (.BOUNTY
		<SET LOC <GETP .BOUNTY ,P?BOUNTY-LOC>>
		<SET ACT <GETP .BOUNTY ,P?BOUNTY-ACCEPTED>>
		<SET INV <GETP .BOUNTY ,P?BOUNTY-INVESTIGATED>>
		<SET RPT <GETP .BOUNTY ,P?BOUNTY-REPORTED>>
		<SET COMP <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
		<COND (<EQUAL? .LOC ,HERE>
			<COND (<AND .ACT .INV .RPT <NOT .COMP>>
				<ADD-BOUNTY .BOUNTY ,HERE>
			)(.ACT
				<ADD-CLUES .BOUNTY ,HERE>
			)>
		)>
	)>>

<ROUTINE SPAWN-BOUNTY ("AUX" BOUNTY)
	<SET BOUNTY <GETP ,HERE ,P?BOUNTY>>
	<COND (.BOUNTY
		<SETUP-BOUNTY .BOUNTY>
	)>>

<ROUTINE SPAWN-MONSTER (LOC "AUX" MONSTER)
	<SET MONSTER <GETP .LOC ,P?MONSTER>>
	<COND (.MONSTER
		<COND (<EQUAL? .MONSTER ,NEKKER>
			<RESET-MONSTER ,NEKKER HP-NEKKER .LOC>
		)(<EQUAL? .MONSTER ,BANDITS>
			<RESET-MONSTER ,BANDITS HP-BANDITS .LOC>
		)>
		<RETURN>
	)>>

;----------------------
"Bounty Debug Routines"

<ROUTINE SET-BOUNTY-STATUS (BOUNTY STATUS)
	<TELL "[DEBUG] SET " D .BOUNTY " FLAG (" <GET BOUNTY-FLAG .STATUS> ") => T" CR>
	<COND (<EQUAL? .STATUS 0> <PUTP .BOUNTY ,P?BOUNTY-ACCEPTED T>)>
	<COND (<EQUAL? .STATUS 1> <PUTP .BOUNTY ,P?BOUNTY-INVESTIGATED T>)>
	<COND (<EQUAL? .STATUS 2> <PUTP .BOUNTY ,P?BOUNTY-REPORTED T>)>
	<COND (<EQUAL? .STATUS 3> <PUTP .BOUNTY ,P?BOUNTY-COMPLETED T>)>>

;----------------------
"Miscellaneous Routines"

<ROUTINE HMMM ()
	<TELL "[Hmmm...]" CR>>

<ROUTINE ARE-WORDS (WORD1 WORD2 "AUX" W1 W2)
	<SET W1 <GETWORD? 1>>
	<SET W2 <GETWORD? 2>>
	<RETURN <AND <EQUAL? .W1 .WORD1> <EQUAL? .W2 .WORD2>>>>

<ROUTINE IS-PHRASE (WORD1 WORD2 WORD3 "AUX" W1 W2 W3)
	<SET W1 <GETWORD? 1>>
	<SET W2 <GETWORD? 2>>
	<SET W3 <GETWORD? 3>>
	<RETURN <AND <EQUAL? .W1 .WORD1> <EQUAL? .W2 .WORD2> <EQUAL? .W3 .WORD3>>>>

<ROUTINE NEED-TO-DISMOUNT ()
	<TELL "You need to dismount from " T ,CURRENT-VEHICLE " first!" CR>>

<ROUTINE NOTHING-HAPPENS ()
	<TELL "[Nothing happens]" CR>>

<ROUTINE TIME-PASSES (CYCLES)
	<SET CYCLES <- .CYCLES 1>>
	<DO (I 1 .CYCLES) <CLOCKER>>>