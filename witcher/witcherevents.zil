;----------------------
"Override"
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
	<COND (<FSET? ,PLAYER ,LIGHTBIT> <TELL " (Cat Eyes)">)>
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
		<TELL "[Night turns to day">
	)(ELSE
		<TELL "[Day turns to night">
	)>
	<COND (<NOT <FSET? ,HERE ,OUTSIDEBIT>> <TELL " outside">)>
	<TELL "]">
	<HLIGHT 0>
	<CRLF>
	<START-DAY-NIGHT-CYCLE>>

<ROUTINE START-DAY-NIGHT-CYCLE ()
	<QUEUE I-DAYNIGHT-CYCLE <+ DAY-LENGTH 1>>>

<ROUTINE I-OIL-IN-STEEL-DEPLETES ()
	<COND (<FIRST? ,STEEL-SWORD> <HLIGHT ,H-BOLD> <TELL "[" T <FIRST? STEEL-SWORD> " wears off]" CR> <CLEAN-SWORD ,STEEL-SWORD T> <HLIGHT 0>)>>

<ROUTINE I-OIL-IN-SILVER-DEPLETES ()
	<COND (<FIRST? ,SILVER-SWORD> <HLIGHT ,H-BOLD> <TELL "[" T <FIRST? SILVER-SWORD> " wears off]" CR> <CLEAN-SWORD ,SILVER-SWORD T> <HLIGHT 0>)>>

<ROUTINE I-CAT-EYES ()
	<SETG WITCHER-CATS-EYE FALSE>
	<WITCHER-CAT-EYES-EFFECT>
	<HLIGHT ,H-BOLD>
	<TELL "[" T ,CAT-EYES-POTION "'s effect wears off]" CR>
	<HLIGHT 0>>

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

<ROUTINE REMOVE-AND-APPLY (OIL SWORD)
	<COND (<FIRST? .SWORD>
		<MOVE <FIRST? .SWORD> ,PLAYER>
	)>
	<MOVE .OIL .SWORD>
	<APPLY-OIL .OIL .SWORD>>

<ROUTINE WITCHER-CAT-EYES-EFFECT()
	<COND (,WITCHER-CATS-EYE <FSET ,PLAYER ,LIGHTBIT>)(<FCLEAR ,PLAYER ,LIGHTBIT>)>>

<ROUTINE WITCHER-EAT ()
	<CRLF>
	<COND (<G? ,WITCHER-FOOD 0>
		<COND (<L? ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
			<TELL "[... you eat some food from your supplies]" CR>
			<SETG WITCHER-FOOD <- ,WITCHER-FOOD WITCHER-CONSUMPTION>>
			<WITCHER-HEAL WITCHER-HEALING-RATE>
		)(ELSE
			<TELL "[... you are at maximum health already]" CR>
		)>
	)(ELSE
		<TELL "[... you do not have any food from your supplies]" CR>
	)>>

<ROUTINE WITCHER-GATHER-FOOD (AMT)
	<TELL "... you found " N .AMT " pieces of food for your supply." CR>
	<SETG WITCHER-FOOD <+ ,WITCHER-FOOD .AMT>>>

<ROUTINE WITCHER-REST ()
	<COND (,RIDING-VEHICLE <PERFORM V?UNMOUNT>)>
	<DEQUEUE I-OIL-IN-SILVER-DEPLETES>
	<DEQUEUE I-OIL-IN-STEEL-DEPLETES>
	<CLEAN-SWORD ,SILVER-SWORD T>
	<CLEAN-SWORD ,STEEL-SWORD T>
	<SETG ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>>

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

<ROUTINE COMBAT-MODE ("AUX" MONSTER (WEAPON NONE) KEY (OIL NONE))
	<SET MONSTER <MONSTER-HERE>>
	<COND (.MONSTER
		<COND (,RIDING-VEHICLE
			<NEED-TO-DISMOUNT>
			<RTRUE>
		)>
		<COND (<IS-DARK ,HERE ,PLAYER>
			<TELL "You cannot enter combat!" CR>
			<FLUSH>
			<RTRUE>
		)>
		<FLUSH>
		<SET WEAPON <CHOOSE-WEAPON .MONSTER>>
		<COND (.WEAPON <SET OIL <FIRST? .WEAPON>>)>
		<REPEAT ()
			<CRLF>
			<TELL "What do you want to do next?" CR>
			<TELL "1 - Attack monster!" CR>
			<TELL "2 - Eat food" CR>
			<TELL "3 - Change my weapon" CR>
			<TELL "4 - Check my status" CR>
			<TELL "5 - Fight to the death!" CR>
			<COND (.OIL <TELL "6 - Apply " D .OIL " to " D .WEAPON CR>)>
			<TELL "0 - Retreat!" CR>
			<SET .KEY <INPUT 1>>
			<COND (<EQUAL? .KEY !\1>
				<CRLF>
				<PERFORM ,V?ATTACK .MONSTER .WEAPON>
				<INPUT 1>
				<COND (<NOT <IN? .MONSTER ,HERE>> <RETURN>)>
			)>
			<COND (<EQUAL? .KEY !\2> <V-WITCHER-EAT> <INPUT 1>)>
			<COND (<EQUAL? .KEY !\3> <SET WEAPON <CHOOSE-WEAPON .MONSTER>>)>
			<COND (<EQUAL? .KEY !\4> <CRLF> <V-WITCHER-STATUS> <INPUT 1>)>
			<COND (<EQUAL? .KEY !\5>
				<SET KEY <RELENTLESS-ASSAULT .MONSTER .WEAPON>>
			)>
			<COND (<EQUAL? .KEY !\6> <COND(.OIL <CRLF> <PERFORM ,V?APPLY-OIL .OIL .WEAPON> <INPUT 1>)>)>
			<COND (<EQUAL? .KEY !\0>
				<SETG ,SHOW-COMBAT-MESSAGES T>
				<COND (<IN? .MONSTER ,HERE> <CRLF> <TELL "You withdraw from combat!" CR>)>
				<RETURN>
			)>
			<UPDATE-STATUS>
		>
	)(ELSE
		<NO-MONSTERS>
	)>>

<ROUTINE COMBAT-SILVER (MONSTER WEAPON "OPT" OIL SUPERIOR-OIL)
	<COMBAT-SWORD .MONSTER .WEAPON ,SILVER-SWORD .OIL .SUPERIOR-OIL>>

<GLOBAL SHOW-COMBAT-MESSAGES T>

<ROUTINE COMBAT-STEEL (MONSTER WEAPON "OPT" OIL SUPERIOR-OIL)
	<COMBAT-SWORD .MONSTER .WEAPON ,STEEL-SWORD .OIL .SUPERIOR-OIL>>

<ROUTINE COMBAT-SWORD (MONSTER WEAPON SWORDTYPE "OPT" OIL SUPERIOR-OIL)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<NOT .WEAPON>
		<COND (,SHOW-COMBAT-MESSAGES <TELL "Not using any weapon isn't going to help you in this situation." CR>)>
		<MONSTER-ATTACKS .MONSTER>
	)(ELSE
		<COND (<FSET? .WEAPON ,WEAPONBIT>
			<COND (<EQUAL? .WEAPON .SWORDTYPE>
				<WITCHER-ATTACK .MONSTER .WEAPON .OIL .SUPERIOR-OIL>
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

<ROUTINE MONSTER-ACTION (MONSTER HP SWORD WEAPON "OPT" OIL SUPERIOR-OIL)
	<COND (<VERB? ATTACK>
		<COND(<EQUAL? .SWORD ,SILVER-SWORD>
			<COMBAT-SILVER .MONSTER .WEAPON .OIL .SUPERIOR-OIL>
		)(ELSE
			<COMBAT-STEEL .MONSTER .WEAPON .OIL .SUPERIOR-OIL>
		)>
	)(<VERB? LOOK-CLOSELY EXAMINE>
		<COND(<L? <GETP .MONSTER P?HIT-POINTS> .HP>
			<TELL "... " T .MONSTER " appears wounded." CR>
		)>
	)>>

<ROUTINE MONSTER-ATTACKS (MONSTER "OPT" DARK "AUX" DMG)
	<COND (<OR <LOC .MONSTER> <G? .MONSTER 0>>
		<COND (<G? <GETP .MONSTER P?HIT-POINTS> 0>
			<COND (.DARK
				<COND (<FSET? .MONSTER ,TOUCHBIT>
					<TELL T .MONSTER " attacks under the cover of darkness!" CR>
				)(ELSE
					<TELL "Something in the dark attacks you!" CR>
				)>
			)(ELSE
				<COND (,SHOW-COMBAT-MESSAGES <TELL CT .MONSTER " attacks!" CR>)>
			)>
			<COND (<AND <NOT .DARK> <PROBABILITY ,WITCHER-DODGE-PROBABILITY>>
				<COND (,SHOW-COMBAT-MESSAGES <TELL "... you manage to dodge its attack!" CR>)>
			)(ELSE
				<SET DMG <GETP .MONSTER P?HIT-DAMAGE>>
				<COND (<NOT ,DAYTIME>
					<COND (.DARK
						<COND (,SHOW-COMBAT-MESSAGES <TELL "... the night makes the attacks more powerful!" CR>)>
						<SET DMG <* .DMG 4>>
					)(T
						<COND (,SHOW-COMBAT-MESSAGES <TELL "... the night makes " T .MONSTER " more powerful!" CR>)>
						<SET DMG <* .DMG 2>>
					)>
				)>
				<WITCHER-COMBAT-DAMAGE .DMG>
			)>
		)>
	)>>

<ROUTINE NO-COMBAT-PLAN (MONSTER WEAPON)
	<TELL "That is your plan? Attacking " T .MONSTER " with " T .WEAPON "?" CR>>

<ROUTINE RELENTLESS-ASSAULT (MONSTER WEAPON "AUX" KEY)
	<COND (<NOT <MONSTER-HERE>> <NO-MONSTERS> <RTRUE>)>
	<SETG ,SHOW-COMBAT-MESSAGES FALSE>
	<CRLF>
	<TELL "You launch into an offensive against " T .MONSTER CR>
	<REPEAT ()
		<PERFORM ,V?ATTACK .MONSTER .WEAPON>
		<COND (<NOT <IN? .MONSTER ,HERE>> <TELL "... and prevailed! " CT .MONSTER <COND (<FSET? .MONSTER ,PLURALBIT> " die.")(ELSE " dies!")> CR> <SET KEY !\0> <RETURN>)>
		<COND (<L? ,WITCHER-HEALTH WITCHER-HEALTH-THRESHOLD>
			<TELL "... after several violent exchanges you are seriously injured. You broke off from your assault!" CR>
			<RETURN>
		)>
		<UPDATE-STATUS>
	>
	<SETG ,SHOW-COMBAT-MESSAGES T>
	<RETURN .KEY>>

<ROUTINE WEAPON-INEFFECTIVE (MONSTER SWORD "AUX" DMG)
	<FSET .MONSTER ,TOUCHBIT>
	<SET DMG <GETP .SWORD P?LOW-DAMAGE>>
	<COND (,SHOW-COMBAT-MESSAGES <TELL "Your " D .SWORD " hits " T .MONSTER " with a dull sound." CR>)>
	<COND (,SHOW-COMBAT-MESSAGES <TELL "... " CT .MONSTER " suffers " N .DMG " points of damage." CR>)>
	<PUTP .MONSTER P?HIT-POINTS <- <GETP .MONSTER P?HIT-POINTS> .DMG>>
	<COND (<L? <GETP .MONSTER P?HIT-POINTS> 1>
		<COND (,SHOW-COMBAT-MESSAGES
			<TELL "... but the blow was fatal. " CT .MONSTER>
			<COND (<FSET? .MONSTER ,PLURALBIT>
				<TELL " die.">
			)(ELSE
				<TELL " dies.">
			)>
			<CRLF>
		)>
		<REMOVE .MONSTER>
		<COMPLETE-IF-BOUNTY .MONSTER ,HERE>
		<RETURN>
	)>
	<COND (,SHOW-COMBAT-MESSAGES <TELL "... Your " D .SWORD " is not effective against " T .MONSTER "!" CR CR>)>>

<ROUTINE WITCHER-ATTACK (MONSTER SWORD "OPT" OIL SUPERIOR-OIL "AUX" DMG)
	<FSET .MONSTER ,TOUCHBIT>
	<SET DMG <GETP .SWORD P?HIT-DAMAGE>>
	<COND (<AND .SUPERIOR-OIL <IN? .SUPERIOR-OIL .SWORD>>
		<SET DMG <+ .DMG <GETP .SUPERIOR-OIL P?BONUS-DAMAGE>>>
	)(<AND .OIL <IN? .OIL .SWORD>>
		<SET DMG <+ .DMG <GETP .OIL P?BONUS-DAMAGE>>>
	)>
	<COND (<PROBABILITY WITCHER-CRITICAL-HIT>
		<SET DMG <* .DMG 2>>
		<COND (,SHOW-COMBAT-MESSAGES <TELL "** CRITICAL HIT!!! **" CR>)>
	)>
	<COND (,SHOW-COMBAT-MESSAGES <TELL "You " <PICK-ONE ATTACK-DESCRIPTIONS> " " T .MONSTER " with your " D .SWORD " for " N .DMG " points of damage." CR>)>
	<PUTP .MONSTER P?HIT-POINTS <- <GETP .MONSTER P?HIT-POINTS> .DMG>>
	<COND (<L? <GETP .MONSTER P?HIT-POINTS> 1>
		<COND (,SHOW-COMBAT-MESSAGES 
			<TELL "... you deal a fatal blow. " CT .MONSTER>
			<COND (<FSET? .MONSTER ,PLURALBIT>
				<TELL " die.">
			)(ELSE
				<TELL " dies.">
			)>
			<CRLF>
		)>
		<REMOVE .MONSTER>
		<COMPLETE-IF-BOUNTY .MONSTER ,HERE>
		<RETURN>
	)>
	<COND (,SHOW-COMBAT-MESSAGES <CRLF>)>>

<ROUTINE WITCHER-COMBAT-DAMAGE (AMT)
	<COND (,SHOW-COMBAT-MESSAGES <TELL "... you took " N .AMT " points of damage." CR>)>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<SETG WITCHER-HEALTH 0>
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
		<SETG WITCHER-HEALTH 0>
		<DEATH-HEALTH>
	)>>

;----------------------
"NPC Actions / Dialog"

<ROUTINE ACCEPT-QUEST (QUEST PERSON ACCEPT "OPT" LOC)
	<COND (<FSET? .QUEST ,BOUNTYBIT>
		<COND (<NOT <GETP .QUEST P?BOUNTY-ACCEPTED>>
			<TELL "Accept " T .QUEST "?">
			<COND (<YES?>
				<PUTP .QUEST P?BOUNTY-ACCEPTED T>
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .PERSON .ACCEPT>
				<COND (.LOC
					<TELL T .LOC " for clues.">
				)>
				<MOVE .QUEST ,CONCEPT-JOURNAL>
			)(ELSE
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .PERSON "That is unfortunate. Let me know if you change your mind.">
			)>
			<CRLF>
		)>
	)(ELSE
		<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
		<RFALSE>
	)>>

<ROUTINE CHECK-QUEST (QUEST THATQUEST PERSON)
	<COND (.THATQUEST
		<COND (<FSET? .THATQUEST ,BOUNTYBIT>
			<COND (<NOT <EQUAL? .THATQUEST .QUEST>>
				<TELL D .PERSON " does not know anything about " T .THATQUEST CR>
				<RFALSE>
			)>
			<RTRUE>
		)>
		<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
		<RFALSE>
	)>
	<RTRUE>>

<ROUTINE CLAIM-REWARD(QUEST)
	<COND (<G? <GETP .QUEST ,P?BOUNTY-REWARD> 0>
		<SETG ,WITCHER-ORENS <+ ,WITCHER-ORENS <GETP .QUEST ,P?BOUNTY-REWARD>>>
		<TELL " Here is your reward. (" N <GETP .QUEST ,P?BOUNTY-REWARD> " Orens)">
		<PUTP .QUEST ,P?BOUNTY-REWARD 0>
	)>>

<ROUTINE MERCHANT (MERCHANT WARES PRICELIST "AUX" ITEM ITEMS KEY)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<VERB? TALK>
		<COND (<OR <NOT .WARES> <NOT .PRICELIST> <NOT .MERCHANT>> <RETURN>)>
		<SET ITEMS <GET .WARES 0>>
		<FLUSH>
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
					<CRLF>
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
			<COND (<EQUAL? .KEY <+ .ITEMS 49> !\0>
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .MERCHANT "Bye!">
				<CRLF>
				<RTRUE>
			)>
			<UPDATE-STATUS-LINE>
		>
	)(<VERB? EXAMINE LOOK-CLOSELY>
		<TALK-HIGHLIGHT-PERSON .MERCHANT "Can I help you? I have things for sale!">
		<CRLF>
	)>>

<ROUTINE QUEST-CHECK-RECOVERED (QUEST PERSON "AUX" ITEMS COUNT RECOVERED)
	<SET ITEMS <GETP .QUEST ,P?QUEST-ITEMS>>
	<SET COUNT 0>
	<SET RECOVERED 0>
	<COND (.ITEMS
		<SET COUNT <GET .ITEMS 0>>
		<DO (I 1 .COUNT)
			<COND (<OR <IN? <GET .ITEMS .I> ,PLAYER> <IN? <GET .ITEMS .I> .PERSON>>
				<SET RECOVERED <+ .RECOVERED 1>>
			)>
		>
	)>
	<RETURN <AND <G? .COUNT 0> <EQUAL? .RECOVERED .COUNT>>>>

<ROUTINE QUEST-CHECK-GIVEN (QUEST PERSON "AUX" ITEMS COUNT GIVEN)
	<SET ITEMS <GETP .QUEST ,P?QUEST-ITEMS>>
	<SET COUNT 0>
	<SET GIVEN 0>
	<COND (.ITEMS
		<SET COUNT <GET .ITEMS 0>>
		<DO (I 1 .COUNT)
			<COND (<IN? <GET .ITEMS .I> .PERSON>
				<SET GIVEN <+ .GIVEN 1>>
			)>
		>
	)>
	<RETURN <AND <G? .COUNT 0> <EQUAL? .GIVEN .COUNT>>>>

<ROUTINE QUEST-CAN-ACCEPT (QUEST PERSON ITEM "AUX" COUNT ITEMS)
	<COND (<OR <NOT .QUEST> <NOT .PERSON> <NOT .ITEM> <FSET? .ITEM ,PERSONBIT>> <RFALSE>)>
	<SET ITEMS <GETP .QUEST ,P?QUEST-ITEMS>>
	<COND (.ITEMS
		<SET COUNT <GET .ITEMS 0>>
		<DO (I 1 .COUNT)
			<COND (<EQUAL? .ITEM <GET .ITEMS .I>> <RTRUE>)>
		>
	)>
	<RFALSE>>

<ROUTINE QUEST-RECOVER-COMPLETED (QUEST PERSON)
	<COND (<QUEST-CHECK-GIVEN .QUEST .PERSON>
		<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-COMPLETE QUEST-RECOVER>>
		<PUTP .QUEST ,P?BOUNTY-COMPLETED T>
		<CLAIM-REWARD .QUEST>
		<QUEST-UPDATE-SCORE .QUEST>
		<MOVE .QUEST ,CONCEPT-JOURNAL>
	)>>

<ROUTINE QUEST-DIALOG (PERSON QUEST REPORT QUEST-TYPE)
	<COND (<NOT <GETP .QUEST P?BOUNTY-INVESTIGATED>>
		<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-INVESTIGATE .QUEST-TYPE>>
		<COND (<EQUAL? .QUEST-TYPE QUEST-MONSTER>
			<TELL T <GETP .QUEST P?BOUNTY-LOC> "." CR>
		)>
	)(ELSE
		<COND (<EQUAL? .QUEST-TYPE QUEST-SEARCH>
			<COND (<GETP .QUEST ,P?BOUNTY-COMPLETED>
				<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-COMPLETE .QUEST-TYPE>>
			)(ELSE
				<TALK-HIGHLIGHT-PERSON .PERSON .REPORT>
				<PUTP .QUEST ,P?BOUNTY-REPORTED T>
				<PUTP .QUEST ,P?BOUNTY-COMPLETED T>
				<CLAIM-REWARD .QUEST>
				<QUEST-UPDATE-SCORE .QUEST>
				<MOVE .QUEST ,CONCEPT-JOURNAL>
			)>
		)(<EQUAL? .QUEST-TYPE QUEST-RECOVER>
			<COND (<NOT <GETP .QUEST P?BOUNTY-REPORTED>>
				<COND (<QUEST-CHECK-RECOVERED .QUEST .PERSON>
					<TALK-HIGHLIGHT-PERSON .PERSON .REPORT>
					<PUTP .QUEST ,P?BOUNTY-REPORTED T>
				)(ELSE
					<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-REPORT .QUEST-TYPE>>
					<CRLF>
				)>
			)(ELSE
				<COND (<NOT <GETP .QUEST ,P?BOUNTY-COMPLETED>>
					<COND (<QUEST-CHECK-GIVEN .QUEST .PERSON>
						<QUEST-RECOVER-COMPLETED .QUEST .PERSON>
					)(ELSE
						<COND (<QUEST-CHECK-RECOVERED .QUEST .PERSON>
							<TALK-HIGHLIGHT-PERSON .PERSON .REPORT>
						)(ELSE
							<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-REPORT .QUEST-TYPE>>
						)>
					)>
				)(ELSE
					<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-COMPLETE .QUEST-TYPE>>
				)>
			)>
		)(<EQUAL? .QUEST-TYPE QUEST-MONSTER>
			<COND (<NOT <GETP .QUEST P?BOUNTY-REPORTED>>
				<TALK-HIGHLIGHT-PERSON .PERSON .REPORT>
				<PUTP .QUEST ,P?BOUNTY-REPORTED T>
			)(ELSE
				<COND (<NOT <GETP .QUEST ,P?BOUNTY-COMPLETED>>
					<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-REPORT .QUEST-TYPE>>
					<TELL T <GETP .QUEST ,P?BOUNTY-MONSTER> " for your reward.">
				)(ELSE
					<TALK-HIGHLIGHT-PERSON .PERSON <GET QUEST-COMPLETE .QUEST-TYPE>>
					<CLAIM-REWARD .QUEST>
					<MOVE .QUEST ,CONCEPT-JOURNAL>
				)>
			)>
		)>
	)>>

<ROUTINE QUEST-DIALOG-LOOP(QUEST THATQUEST PERSON TEXT ACCEPT "OPT" LOC "AUX" KEY)
	<COND (<NOT <CHECK-QUEST .QUEST .THATQUEST .PERSON>>
		<RETURN>
	)>
	<FLUSH>
	<REPEAT ()
		<TALK-HIGHLIGHT-PERSON .PERSON "">
		<CRLF>
		<TELL "Are you here about " T .QUEST "?" CR>
		<TELL "1 - Yes, tell me more about this." CR>
		<TELL "2 - I accept the job." CR>
		<TELL "3 - Goodbye for now." CR>
		<TELL "Your response: ">
		<SET KEY <INPUT 1>>
		<CRLF>
		<TALK-RESPONSE .KEY !\1 .TEXT .PERSON>
		<COND (<EQUAL? .KEY !\2>
			<ACCEPT-QUEST .QUEST .PERSON .ACCEPT .LOC>
			<RETURN>
		)(<EQUAL? .KEY !\3 !\0>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .PERSON "Bye!">
			<CRLF>
			<RTRUE>
		)>
		<CRLF>
		<UPDATE-STATUS>
	>>

<ROUTINE QUEST-TALK (QUEST PERSON TEXT GREET REPORT QUEST-TYPE "AUX" UNLOCKED-BY)
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
		<SET UNLOCKED-BY <GETP .PERSON ,P?UNLOCKED-BY>>
		<COND (.UNLOCKED-BY
			<COND (<NOT <GETP .UNLOCKED-BY ,P?BOUNTY-COMPLETED>>
				<TALK-HIGHLIGHT-PERSON .PERSON "Leave me be, Witcher!">
				<CRLF>
				<RTRUE>
			)>
		)>
		<COND (<OR <IN? .QUEST ,PLAYER> <IN? .QUEST ,CONCEPT-JOURNAL> <IN? .QUEST .PERSON>>
			<COND (<GETP .QUEST P?BOUNTY-ACCEPTED>
				<COND (<NOT <CHECK-QUEST .QUEST ,PRSI .PERSON>>
					<RETURN>
				)>
				<COND (<EQUAL? .QUEST-TYPE ,QUEST-MONSTER>
					<QUEST-DIALOG .PERSON .QUEST .REPORT QUEST-MONSTER>
				)(<EQUAL? .QUEST-TYPE QUEST-RECOVER>
					<QUEST-DIALOG .PERSON .QUEST .REPORT QUEST-RECOVER>
				)(<EQUAL? .QUEST-TYPE QUEST-SEARCH>
					<QUEST-DIALOG .PERSON .QUEST .REPORT QUEST-SEARCH>
				)>
				<CRLF>
			)(ELSE
				<COND (<EQUAL? .QUEST-TYPE ,QUEST-MONSTER>
					<QUEST-DIALOG-LOOP .QUEST ,PRSI .PERSON .TEXT <GET QUEST-ACCEPT QUEST-MONSTER> <GETP .QUEST ,P?BOUNTY-LOC>>
				)(<EQUAL? .QUEST-TYPE QUEST-SEARCH>
					<QUEST-DIALOG-LOOP .QUEST ,PRSI .PERSON .TEXT <GET QUEST-ACCEPT QUEST-SEARCH>>
				)(<EQUAL? .QUEST-TYPE QUEST-RECOVER>
					<QUEST-DIALOG-LOOP .QUEST ,PRSI .PERSON .TEXT <GET QUEST-ACCEPT QUEST-RECOVER>>
				)>
			)>
		)(ELSE
			<TALK-HIGHLIGHT-PERSON .PERSON .GREET>
			<CRLF>
		)>
	)(<VERB? EXAMINE LOOK-CLOSELY>
		<TALK-HIGHLIGHT-PERSON .PERSON "In most cultures it is rude to stare!">
		<CRLF>
	)(<VERB? ACCEPT-BOUNTY>
		<COND (<OR <NOT <FSET? ,PRSI ,PERSONBIT>> <NOT <FSET? ,PRSO ,BOUNTYBIT>> <NOT <EQUAL? .QUEST ,PRSO>>>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
			<RETURN>
		)(ELSE
			<COND (<GETP .QUEST ,P?BOUNTY-ACCEPTED> <TELL CR "You already agreed to take on " T .QUEST CR> <RTRUE>)>
			<COND (<AND <NOT <IN? .QUEST ,PLAYER>> <NOT <IN? .QUEST ,CONCEPT-JOURNAL>> <NOT <IN? .QUEST .PERSON>>>
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
				<RETURN>
			)>
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .PERSON .TEXT>
			<CRLF><CRLF>
			<COND (<EQUAL? .QUEST-TYPE ,QUEST-MONSTER>
				<ACCEPT-QUEST .QUEST .PERSON <GET QUEST-ACCEPT QUEST-MONSTER> <GETP .QUEST ,P?BOUNTY-LOC>>
			)(<EQUAL? .QUEST-TYPE QUEST-SEARCH>
				<ACCEPT-QUEST .QUEST .PERSON <GET QUEST-ACCEPT QUEST-SEARCH>>
			)(<EQUAL? .QUEST-TYPE QUEST-RECOVER>
				<ACCEPT-QUEST .QUEST .PERSON <GET QUEST-ACCEPT QUEST-RECOVER>>
			)>
		)>
	)(<VERB? GIVE>
		<COND (<EQUAL? .QUEST-TYPE QUEST-RECOVER>
			<COND (<AND <FSET? ,PRSI ,PERSONBIT> <EQUAL? ,PRSI .PERSON> <NOT <FSET? ,PRSO ,PERSONBIT>> <QUEST-CAN-ACCEPT .QUEST .PERSON ,PRSO>>
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .PERSON "Thanks for ">
				<TELL T ,PRSO>
				<CRLF>
				<MOVE ,PRSO .PERSON>
				<QUEST-RECOVER-COMPLETED .QUEST .PERSON>
				<RTRUE>
			)(ELSE
				<COND (<FSET? ,PRSO ,PERSONBIT>
					<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
				)(ELSE
					<TALK-HIGHLIGHT-PERSON .PERSON "I can't accept ">
					<TELL T ,PRSO>
				)>
				<CRLF>
			)>
			<RTRUE>
		)>
		<RFALSE>
	)(<VERB? REPORT-QUEST>
		<COND (<AND .QUEST <GETP .QUEST ,P?BOUNTY-ACCEPTED>>
			<COND (,PRSI
				<COND (<AND <FSET? ,PRSI ,BOUNTYBIT>> <FSET? ,PRSO ,PERSONBIT>
					<COND (<NOT <CHECK-QUEST .QUEST ,PRSI .PERSON>>
						<RETURN>
					)>
				)(<AND <FSET? ,PRSO ,BOUNTYBIT>> <FSET? ,PRSI ,PERSONBIT>
					<COND (<NOT <CHECK-QUEST .QUEST ,PRSO .PERSON>>
						<RETURN>
					)>
				)(ELSE
					<CRLF>
					<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
					<RETURN>
				)>
			)>
			<CRLF>
			<QUEST-DIALOG .PERSON .QUEST .REPORT .QUEST-TYPE>
			<CRLF>
			<RTRUE>
		)(ELSE
			<CRLF>
			<TALK-HIGHLIGHT-PERSON .PERSON ""><WHAT-NOW>
		)>
	)>>

<ROUTINE QUEST-UPDATE-SCORE (QUEST)
	<COND (<OR <NOT .QUEST> <NOT <FSET? .QUEST ,BOUNTYBIT>>> <RETURN>)>
	<SETG SCORE <+ ,SCORE <GETP .QUEST ,P?VALUE>>>>

<ROUTINE SMITH (SMITH ENHANCEMENTS PRICELIST "AUX" ITEM KEY PRICE DMG)
	<COND (,RIDING-VEHICLE
		<NEED-TO-DISMOUNT>
		<RTRUE>
	)>
	<COND (<VERB? TALK>
		<FLUSH>
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
			<COND (<EQUAL? .KEY !\3 !\0>
				<CRLF>
				<TALK-HIGHLIGHT-PERSON .SMITH "Bye!">
				<CRLF>
				<RTRUE>
			)>
		>
	)(<VERB? EXAMINE LOOK-CLOSELY>
		<TALK-HIGHLIGHT-PERSON .SMITH "Hello? How may I be of service?">
		<CRLF>
	)>>

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
	<COND (<FSET? .TOPIC ,TOPICBIT>
		<CRLF>
		<HLIGHT ,H-INVERSE>
		<TELL "Topic: " D .TOPIC CR CR>
		<HLIGHT 0>
		<TELL <GETP .TOPIC P?LDESC> CR>
	)(T
		<TELL CR "[The codex is silent about such things.]" CR>
	)>>

<ROUTINE LIST-TOPICS ("OPT" FILTER "AUX" TOPIC)
	<CRLF>
	<HLIGHT ,H-INVERSE>
	<TELL "List of Topics" CR CR>
	<HLIGHT 0>
	<SET TOPIC <FIRST? ,GENERIC-OBJECTS>>
	<REPEAT ()
		<COND (<NOT .TOPIC>
			<RETURN>
		)(ELSE 
			<COND (<FSET? .TOPIC ,TOPICBIT>
				<COND (<OR <NOT .FILTER> <AND .FILTER <FSET? .TOPIC .FILTER>>>
					<TELL D .TOPIC CR>
				)>
			)>
		)>
		<SET TOPIC <NEXT? .TOPIC>>
	>>

;----------------------
"Location setup"

<ROUTINE CHECK-FOOD-AVAILABILITY (LOC)
	<COND (<FSET? .LOC ,HASFOOD>
		<TELL "[... you can probably get some food here.]" CR>
	)>>

<ROUTINE CHECK-ATTACKS-IN-THE-DARK (LOC PERSON "AUX" MONSTER)
	<SET MONSTER <MONSTER-HERE .LOC>>
	<COND (<AND <NOT <FSET? .LOC ,LIGHTBIT>> <NOT <FIND-IN .PERSON ,LIGHTBIT>> <NOT <FIND-IN .LOC ,LIGHTBIT>> .MONSTER>
		<CRLF> 
		<MONSTER-ATTACKS .MONSTER T>
		<FLUSH>
	)>>

<ROUTINE CHECK-ORENS-AVAILABILITY (LOC)
	<COND (<OR <GETP .LOC ,P?ORENS> <GETP .LOC ,P?RANDOM-ORENS>>
		<TELL "[... there are some coins here.]" CR>
	)>>

<ROUTINE CHECK-TRAVEL-RESTRICTIONS (LOC)
	<COND (<NOT ,RIDING-VEHICLE>
		<COND (<AND <NOT <FSET? .LOC ,ADJACENT>> <AND <FSET? .LOC ,OUTSIDEBIT> <NOT <FSET? ,LAST-LOC ,ADJACENT>>>>
			<TELL "A long time passed before you arrived." CR CR>
			<TIME-PASSES WITCHER-TRAVEL-TIME>
		)>
	)(ELSE
		<COND (<NOT <FSET? .LOC ,OUTSIDEBIT>>
			<TELL "You leave " D ,CURRENT-VEHICLE " at " T ,LAST-LOC "." CR CR>
			<FCLEAR ,CURRENT-VEHICLE ,NDESCBIT>
			<SETG ,RIDING-VEHICLE FALSE>
			<SETG ,CURRENT-VEHICLE NONE>
		)(ELSE
			<MOVE ,CURRENT-VEHICLE .LOC>
		)>
	)>>

<ROUTINE VISITED (LOC DIR)
	<RETURN <FSET? <GETP .LOC .DIR> ,TOUCHBIT>>>

<ROUTINE DESCRIBE-EXITS (LOC)
	<COND (<IS-DARK .LOC ,PLAYER>
		<PITCH-BLACK>
		<FLUSH>
		<RTRUE>
	)>
	<COND (<NOT .LOC> <RETURN>)>
	<CRLF>
	<HLIGHT ,H-BOLD>
	<TELL "Exits">
	<HLIGHT 0>
	<CRLF>
	<COND (<IS-VISIBLE .LOC ,P?NW> <COND (<VISITED .LOC ,P?NW> <TELL "Northwest: " D <GETP .LOC ,P?NW> CR>)(<TELL "Northwest" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?NORTH> <COND (<VISITED .LOC ,P?NORTH> <TELL "North: " D <GETP .LOC ,P?NORTH> CR>)(<TELL "North" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?NE> <COND (<VISITED .LOC ,P?NE> <TELL "Northeast: " D <GETP .LOC ,P?NE> CR>)(<TELL "Northeast" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?WEST> <COND (<VISITED .LOC ,P?WEST> <TELL "West: " D <GETP .LOC ,P?WEST> CR>)(<TELL "West" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?EAST> <COND (<VISITED .LOC ,P?EAST> <TELL "East: " D <GETP .LOC ,P?EAST> CR>)(<TELL "East" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?SW> <COND (<VISITED .LOC ,P?SW> <TELL "Southwest: " D <GETP .LOC ,P?SW> CR>)(<TELL "Southwest" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?SOUTH> <COND (<VISITED .LOC ,P?SOUTH> <TELL "South: " D <GETP .LOC ,P?SOUTH> CR>)(<TELL "South" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?SE> <COND (<VISITED .LOC ,P?SE> <TELL "Southeast: " D <GETP .LOC ,P?SE> CR>)(<TELL "Southeast" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?UP> <COND (<VISITED .LOC ,P?UP> <TELL "Up: " D <GETP .LOC ,P?UP> CR>)(<TELL "Up" CR>)>)>
	<COND (<IS-VISIBLE .LOC ,P?DOWN> <COND (<VISITED .LOC ,P?DOWN> <TELL "Down: " D <GETP .LOC ,P?DOWN> CR>)(<TELL "Down" CR>)>)>
	<RTRUE>>

<ROUTINE DESCRIBE-LOCATION (LOC)
	<TELL <GETP .LOC ,P?LDESC> CR>>

<ROUTINE IS-ADJACENT (THIS THAT)
	<COND (<NOT .THIS> <RFALSE>)>
	<COND (<EQUAL? .THIS .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?NW> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?NORTH> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?NE> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?WEST> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?EAST> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?SW> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?SOUTH> .THAT> <RTRUE>)>
	<COND (<EQUAL? <GETP .THIS ,P?SE> .THAT> <RTRUE>)>
	<RFALSE>>

<ROUTINE IS-DARK(LOC PERSON)
	<RETURN <AND <NOT <FSET? .LOC ,LIGHTBIT>> <NOT <FIND-IN .PERSON ,LIGHTBIT>> <NOT <FIND-IN .LOC ,LIGHTBIT>>>>>

<ROUTINE IS-VISIBLE (LOC DIR "AUX" WHERE INV)
	<SET WHERE <GETP .LOC .DIR>>
	<COND (<NOT .WHERE> <RETURN FALSE>)>
	<SET INV <FSET? .WHERE ,INVISIBLE>>
	<RETURN <AND .WHERE <NOT .INV>>>>

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
	)>
	<RTRUE>>

;----------------------
"Monster / Bounty Setup"

<ROUTINE ADD-BOUNTY (BOUNTY LOC "AUX" MONSTER)
	<COND (<EQUAL? .LOC <GETP .BOUNTY ,P?BOUNTY-LOC>>
		<COND (<GETP .BOUNTY ,P?BOUNTY-REPORTED>
			<COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
				<SET MONSTER <GETP .BOUNTY ,P?BOUNTY-MONSTER>>
				<COND (<EQUAL? .MONSTER ,GRIFFIN> <RESET-MONSTER ,GRIFFIN ,HP-GRIFFIN .LOC>)>
				<COND (<EQUAL? .MONSTER ,ALGHOUL> <RESET-MONSTER ,ALGHOUL ,HP-ALGHOUL .LOC>)>
				<COND (<EQUAL? .MONSTER ,BEAR> <RESET-MONSTER ,BEAR ,HP-BEAR .LOC>)>
				<COND (<EQUAL? .MONSTER ,BANDITS> <RESET-MONSTER ,BANDITS HP-BANDITS .LOC>)>
				<COND (<EQUAL? .MONSTER ,WRAITH-JAENY> <RESET-MONSTER ,WRAITH-JAENY HP-JAENY .LOC>)>
			)>
		)>
	)>>

<ROUTINE ADD-CLUES (QUEST LOC)
	<COND
		(<EQUAL? .LOC ,CROSSROADS> <POPULATE-CLUES-IN-LOC .LOC .QUEST WHITE-ORCHARD-CLUES>)
		(<EQUAL? .LOC ,WHITE-ORCHARD-FARM> <POPULATE-CLUES-IN-LOC .LOC .QUEST FARM-CLUES>)
		(<EQUAL? .LOC ,ABANDONED-VILLAGE-WELL> <POPULATE-CLUES-IN-LOC .LOC .QUEST ABANDONED-VILLAGE-CLUES>)
		(<EQUAL? .LOC ,ABANDONED-VILLAGE-WELL-BOTTOM> <POPULATE-CLUES-IN-LOC .LOC .QUEST MISSING-BRACELET-CLUES>)
	>>

<ROUTINE ADD-TOPIC (TOPIC)
	<MOVE .TOPIC ,GENERIC-OBJECTS>
	<FSET .TOPIC ,TOPICBIT>
	<CRLF>
	<TELL "[A new topic has been added to the codex: "><HLIGHT ,H-BOLD><TELL D .TOPIC><HLIGHT 0><TELL "]"><CRLF>>

<ROUTINE CHECK-IF-BOUNTY-INVESTIGATED (CLUE-TABLE "AUX" CLUES CLUES-INVESTIGATED)
	<SET CLUES <GET .CLUE-TABLE 0>>
	<SET CLUES-INVESTIGATED 0>
	<DO (I 1 .CLUES)
		<COND (<GET .CLUE-TABLE .I>
			<SET CLUES-INVESTIGATED <+ .CLUES-INVESTIGATED 1>>
		)>
	>
	<RETURN <EQUAL? .CLUES .CLUES-INVESTIGATED>>>

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

<ROUTINE CHECK-IF-UNLOCKED (LOC "AUX" BOUNTY)
	<SET BOUNTY <GETP .LOC ,P?UNLOCKED-BY>>
	<COND (.BOUNTY <RETURN <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>)>
	<RTRUE>>

<ROUTINE COMPLETE-IF-BOUNTY (MONSTER LOC "AUX" BOUNTY BOUNTY-MONSTER UNLOCKED-AREA)
	<SET BOUNTY <GETP .LOC ,P?BOUNTY>>
	<COND (.BOUNTY
		<SET BOUNTY-MONSTER <GETP .BOUNTY ,P?BOUNTY-MONSTER>>
		<SET UNLOCKED-AREA <GETP .BOUNTY ,P?BOUNTY-UNLOCKS>>
		<COND (<EQUAL? .MONSTER .BOUNTY-MONSTER>
			<PUTP .BOUNTY ,P?BOUNTY-COMPLETED T>
			<QUEST-UPDATE-SCORE .BOUNTY>
			<MOVE .BOUNTY ,CONCEPT-JOURNAL>
		)>
		<COND (.UNLOCKED-AREA
			<FCLEAR .UNLOCKED-AREA ,INVISIBLE>
		)>
	)>>

<ROUTINE INVESTIGATE-CLUE (CLUE CLUE-TABLE CLUE-NUM "OPT" (TOUCH FALSE))
    <COND (<EQUAL? ,PRSO .CLUE>
		<PUT .CLUE-TABLE .CLUE-NUM T>
		<COND (.TOUCH <FSET .CLUE ,TOUCHBIT>)>
	)>>

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

<ROUTINE SETUP-BOUNTY (HERE BOUNTY "AUX" LOC ACT INV RPT COMP)
	<COND (.BOUNTY
		<SET LOC <GETP .BOUNTY ,P?BOUNTY-LOC>>
		<SET ACT <GETP .BOUNTY ,P?BOUNTY-ACCEPTED>>
		<SET INV <GETP .BOUNTY ,P?BOUNTY-INVESTIGATED>>
		<SET RPT <GETP .BOUNTY ,P?BOUNTY-REPORTED>>
		<SET COMP <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
		<COND (<EQUAL? .LOC .HERE>
			<COND (<AND .ACT .INV .RPT <NOT .COMP>>
				<ADD-BOUNTY .BOUNTY .HERE>
			)(.ACT
				<ADD-CLUES .BOUNTY .HERE>
			)>
		)>
	)>>

<ROUTINE SPAWN-BOUNTY (LOC "AUX" BOUNTY)
	<SET BOUNTY <GETP .LOC ,P?BOUNTY>>
	<COND (.BOUNTY
		<SETUP-BOUNTY .LOC .BOUNTY>
	)>>

<ROUTINE SPAWN-MONSTER (LOC "AUX" MONSTER RESPAWN LASTRESPAWN)
	<SET MONSTER <GETP .LOC ,P?MONSTER>>
	<COND (.MONSTER
		<SET RESPAWN <GETP .LOC ,P?RESPAWN>>
		<SET LASTRESPAWN <GETP .LOC ,P?LASTRESPAWN>>
		<COND (<AND <G? .RESPAWN 0> <OR <G? ,MOVES <+ .LASTRESPAWN .RESPAWN>> <0? .LASTRESPAWN>>>
			<PUTP .LOC ,P?LASTRESPAWN ,MOVES>
			<COND (<EQUAL? .MONSTER ,NEKKER> <RESET-MONSTER ,NEKKER HP-NEKKER .LOC>)>
			<COND (<EQUAL? .MONSTER ,GHOULS> <RESET-MONSTER ,GHOULS HP-GHOULS .LOC>)>
		)>
		<RETURN>
	)>>

;----------------------
"Miscellaneous Routines"

<ROUTINE HMMM ()
	<TELL "[Hmmm...]" CR>>

<ROUTINE WREQ (NUM)
	<RETURN <L? <GETB ,LEXBUF 1> .NUM>>>

<ROUTINE GET-WORD (N "AUX" W)
	<COND (<WREQ 1> <RFALSE>)>
	<SET W <- <* .N 2> 1>>
	<RETURN <GET ,LEXBUF .W>>>

<ROUTINE ARE-WORDS (WORD1 WORD2 "AUX" W1 W2)
	<COND (<WREQ 2> <RFALSE>)>
	<SET W1 <GET-WORD 1>>
	<SET W2 <GET-WORD 2>>
	<RETURN <AND <EQUAL? .W1 .WORD1> <EQUAL? .W2 .WORD2>>>>

<ROUTINE FLUSH ()
	<SETG P-CONT 0>>

<ROUTINE IS-MONSTER (OBJ)
	<RETURN <FSET? .OBJ ,MONSTERBIT>>>

<ROUTINE IS-PHRASE (WORD1 WORD2 WORD3 "AUX" W1 W2 W3)
	<COND (<WREQ 3> <RFALSE>)>
	<SET W1 <GET-WORD 1>>
	<SET W2 <GET-WORD 2>>
	<SET W3 <GET-WORD 3>>
	<RETURN <AND <EQUAL? .W1 .WORD1> <EQUAL? .W2 .WORD2> <EQUAL? .W3 .WORD3>>>>

<ROUTINE LIST-QUESTS (LOC "OPT" SCORE "AUX" QUEST COUNT)
	<COND (<NOT .LOC> <SET .LOC ,HERE>)>
	<SET QUEST <FIRST? .LOC>>
	<SET COUNT 0>
	<REPEAT ()
		<COND (<NOT .QUEST>
			<RETURN .COUNT>
		)(ELSE 
			<COND (<FSET? .QUEST ,BOUNTYBIT>
				<COND (<NOT .SCORE>
					<TELL D .QUEST " => ">
					<COND (<GETP .QUEST ,P?BOUNTY-COMPLETED>
						<HLIGHT ,H-BOLD>
						<TELL "completed">
					)(<NOT <GETP .QUEST ,P?BOUNTY-ACCEPTED>>
						<TELL "unknown">
					)(ELSE
						<ITALICIZE "in progress">
					)>
					<CRLF>
					<SET COUNT <+ .COUNT 1>>
				)(ELSE
					<COND (<GETP .QUEST ,P?BOUNTY-COMPLETED>
					<TELL D .QUEST " => ">
						<HLIGHT ,H-BOLD>
						<TELL "+ " N <GETP .QUEST ,P?VALUE>>
						<CRLF>
						<SET COUNT <+ .COUNT 1>>
					)>
				)>
				<HLIGHT 0>
			)>
		)>
		<SET QUEST <NEXT? .QUEST>>
	>
	<RETURN .COUNT>>

<ROUTINE MONSTER-HERE ("OPT" LOC)
	<COND(<NOT .LOC> <SET LOC ,HERE>)>
	<RETURN <FIND-IN .LOC ,MONSTERBIT>>>

<ROUTINE NEED-TO-DISMOUNT ()
	<TELL "You need to dismount from " T ,CURRENT-VEHICLE " first!" CR>
	<FLUSH>>

<ROUTINE NO-MONSTERS()
	<TELL "There are no monsters here!" CR>>

<ROUTINE NOT-THE-TIME()
	<TELL CR "The monster is here! Now is not the time for that!" CR>>

<ROUTINE NOTHING-HAPPENS ()
	<TELL "[Nothing happens]" CR>>

<ROUTINE NPC-SLEEP (LOC "AUX" PERSON)
	<COND (<NOT .LOC> <SET .LOC ,HERE>)>
	<SET PERSON <FIRST? .LOC>>
	<REPEAT ()
		<COND (<NOT .PERSON>
			<RETURN>
		)(ELSE 
			<COND (<AND <FSET? .PERSON ,PERSONBIT> <NOT <EQUAL? .PERSON ,PLAYER ,ROACH>> <NOT <FSET? .PERSON ,MONSTERBIT>>>
				<COND (,DAYTIME
					<FCLEAR .PERSON ,INVISIBLE>
					<FCLEAR .PERSON ,NDESCBIT>
				)(T
					<FSET .PERSON ,INVISIBLE>
					<FSET .PERSON ,NDESCBIT>
				)>
			)>
		)>
		<SET PERSON <NEXT? .PERSON>>
	>
	<RTRUE>>

<ROUTINE PITCH-BLACK()
	<TELL "It is pitch black. You can't see a thing." CR>>

<ROUTINE PROBABILITY(ODDS)
	<RETURN <L? <RANDOM 100> .ODDS>>>

<ROUTINE TIME-PASSES (CYCLES)
	<SET CYCLES <- .CYCLES 1>>
	<DO (I 1 .CYCLES) <UPDATE-STATUS>>>

<ROUTINE UPDATE-STATUS()
	<CLOCKER>
	<UPDATE-STATUS-LINE>>

<ROUTINE WAIT-UNTIL (OBJ "OPT" SILENT "AUX" THIS THAT)
	<COND (<MONSTER-HERE>
		<TELL CR "You cannot wait until " T .OBJ " while a monster is around." CR>
		<RTRUE>
	)>
	<COND (<EQUAL? .OBJ ,CONCEPT-TOMORROW>
		<WITCHER-REST>
		<COND (,DAYTIME
			<WAIT-UNTIL ,CONCEPT-EVENING T>
			<WAIT-UNTIL ,CONCEPT-MORNING T>
		)(ELSE
			<WAIT-UNTIL ,CONCEPT-MORNING T>
			<WAIT-UNTIL ,CONCEPT-EVENING T>
		)>
		<CRLF>
		<V-LOOK>
		<RETURN>
	)>
	<COND (<EQUAL? .OBJ ,CONCEPT-MORNING ,CONCEPT-EVENING>
		<SET THIS <AND ,DAYTIME <EQUAL? .OBJ ,CONCEPT-MORNING>>>
		<SET THAT <AND <NOT ,DAYTIME> <EQUAL? .OBJ ,CONCEPT-EVENING>>>
		<COND (<AND <NOT .THIS> <NOT .THAT>>
			<COND (<NOT .SILENT> <WITCHER-REST>)>
			<REPEAT ()
				<COND (<EQUAL? .OBJ ,CONCEPT-MORNING>
					<COND (,DAYTIME <RETURN>)>
				)(<EQUAL? .OBJ ,CONCEPT-EVENING>
					<COND (<NOT ,DAYTIME> <RETURN>)>
				)>
				<UPDATE-STATUS>
			>
			<COND (<NOT .SILENT> <CRLF> <V-LOOK>)>
			<RTRUE>
		)>
	)>
	<HMMM>>

<ROUTINE WHAT-NOW ()
	<TELL "The what now?" CR>>