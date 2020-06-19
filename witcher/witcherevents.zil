;----------------------
"Death Routines"

<ROUTINE DEATH-COMBAT ()
	<CRLF>
	<JIGS-UP "In all your years killing monsters, you have not found something you could not overcome until today.">>

<ROUTINE DEATH-FATIGUE ()
	<CRLF>
	<JIGS-UP "In all your years killing monsters, you never expected that you could die from poor health." >>

;----------------------
"World Cycles"

<ROUTINE I-DAYNIGHT-CYCLE ()
	<SETG DAYTIME <NOT ,DAYTIME>>
	<START-DAY-NIGHT-CYCLE>>

<ROUTINE I-WITCHER-EAT ()
	<WITCHER-EAT>
	<QUEUE I-WITCHER-EAT WITCHER-EAT-TURNS>>

<ROUTINE START-DAY-NIGHT-CYCLE ()
	<QUEUE I-DAYNIGHT-CYCLE DAY-LENGTH>>

<ROUTINE START-EATING-CYCLE ()
	<QUEUE I-WITCHER-EAT WITCHER-EAT-TURNS>>

<ROUTINE STOP-EATING-CYCLE ()
	<DEQUEUE I-WITCHER-EAT>>

;----------------------
"Witcher actions"

<ROUTINE APPLY-OIL (OIL SWORD)
	<TELL "You apply " T .OIL " onto " T .SWORD CR>>

<ROUTINE CANNOT-APPLY-OIL (OIL SWORD)
	<TELL "You cannot apply " T .OIL " to " T .SWORD ", or if you can, it will not be effective." CR>>

<ROUTINE CHECK-SWORD-OIL (SWORD)
	<COND (<FIRST? .SWORD>
		<TELL "with applied " D <FIRST? .SWORD>>
	)(ELSE
		<TELL "with no oils applied">
	)>
	<CRLF>>

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
		<WITCHER-HEALTH-DAMAGE WITCHER-FATIGUE-RATE "hunger">
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
		<COND (<EQUAL? .KEY !\3> <RETURN <>>)>
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
		<RESET-CODEX-MONSTER ,HERE>
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
		<RESET-CODEX-MONSTER ,HERE>
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
	<COND (<L? ,WITCHER-HEALTH WITCHER-MAX-HEALTH>
		<TELL "... you heal " N .AMT " points." CR>
	)>
	<SETG WITCHER-HEALTH <+ ,WITCHER-HEALTH .AMT>>
	<COND (<G? ,WITCHER-HEALTH WITCHER-MAX-HEALTH>
		<SETG WITCHER-HEALTH WITCHER-MAX-HEALTH>
	)>>

<ROUTINE WITCHER-HEALTH-DAMAGE (AMT REASON)
	<TELL "... your " .REASON " hits you for " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-FATIGUE>
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

<ROUTINE GENERIC-BOUNTY-DIALOG (PERSON BOUNTY)
    <COND (<NOT <GETP .BOUNTY P?BOUNTY-INVESTIGATED>>
        <TALK-HIGHLIGHT-PERSON .PERSON "You should probably continue investigating ">
        <TELL T <GETP .BOUNTY P?BOUNTY-LOC> " area." CR>
    )(ELSE
        <COND (<NOT <GETP .BOUNTY P?BOUNTY-REPORTED>>
            <TALK-HIGHLIGHT-PERSON .PERSON "You have enough clues about the monster you are dealing with! Now is the time to deal with it!">
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

<ROUTINE GENERIC-BOUNTY-TALK (BOUNTY PERSON TEXT "AUX" KEY)
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
                <GENERIC-BOUNTY-DIALOG .PERSON .BOUNTY>
            )(ELSE
                <COND (<NOT <CHECK-BOUNTY .BOUNTY ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <STOP-EATING-CYCLE>
                <REPEAT ()
                    <TALK-HIGHLIGHT-PERSON .PERSON "">
                    <CRLF>
                    <TELL "Are you here about the bounty (" T .BOUNTY ")?" CR>
                    <TELL "1 - I'm here about the bounty." CR> 
                    <TELL "2 - I accept the bounty." CR>
                    <TELL "3 - Goodbye for now." CR>
                    <TELL "Your response: ">
                    <SET KEY <INPUT 1>>
                    <CRLF>
                    <TALK-RESPONSE .KEY !\1 .TEXT ,PRSO>
                    <COND (<EQUAL? .KEY !\2>
                        <ACCEPT-BOUNTY .BOUNTY ,PRSO>
                        <START-EATING-CYCLE>
                        <RETURN>
                    )(<EQUAL? .KEY !\3>
                        <CRLF>
                        <TALK-HIGHLIGHT-PERSON .PERSON "Bye!">
                        <CRLF>
                        <START-EATING-CYCLE>
                        <RETURN>
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
		<WITCHER-HEALTH-DAMAGE WITCHER-FATIGUE-RATE "fatigue">
	)(ELSE
		<MOVE ,CURRENT-VEHICLE ,HERE>
	)>>

<ROUTINE DESCRIBE-LOCATION (LOC)
	<TELL <GETP .LOC ,P?LDESC> CR>>

<ROUTINE MOVE-ROACH ()
	<COND (<IN? ,ROACH ,HERE>
		<REMOVE ,TOPIC-ROACH>
	)(ELSE
		<MOVE ,TOPIC-ROACH ,GLOBAL-OBJECTS>
	)>>

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
    <COND (<EQUAL? .LOC ,CROSSROADS>
        <COND (<GETP .BOUNTY ,P?BOUNTY-REPORTED>
            <COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
                <COND (<NOT <IN? ,GRIFFIN ,CROSSROADS>>
                    <RESET-MONSTER ,GRIFFIN ,HP-GRIFFIN ,CROSSROADS>
                    <REMOVE ,TOPIC-GRIFFINS>
                )>
            )>
        )>
    )>>

<ROUTINE ADD-CLUES (BOUNTY LOC "AUX" CLUES)
    <COND (<EQUAL? .LOC ,CROSSROADS>
        <COND (<AND <GETP .BOUNTY ,P?BOUNTY-ACCEPTED> <NOT <GETP .BOUNTY ,P?BOUNTY-INVESTIGATED>>>
			<SET CLUES <GET WHITE-ORCHARD-CLUES 0>>
			<DO (I 1 .CLUES)
				<MOVE <GET WHITE-ORCHARD-CLUES .I> ,CROSSROADS>
			>
        )>
    )>>

<ROUTINE RESET-CODEX-MONSTER (LOC "AUX" MONSTER BOUNTY BOUNTY-MONSTER)
	<COND (.LOC
		<SET MONSTER <GETP .LOC ,P?MONSTER>>
		<COND (.MONSTER
			<COND (<EQUAL? .MONSTER ,NEKKER>
				<MOVE ,TOPIC-NEKKER ,GLOBAL-OBJECTS>
			)(<EQUAL? .MONSTER ,BANDITS>
			
			)>
		)>
		<SET BOUNTY <GETP .LOC ,P?BOUNTY>>
		<COND (.BOUNTY
			<SET BOUNTY-MONSTER <GETP .BOUNTY P?BOUNTY-MONSTER>>
			<COND (<EQUAL? .BOUNTY-MONSTER ,GRIFFIN>
				<MOVE ,TOPIC-GRIFFINS ,GLOBAL-OBJECTS>
			)>
		)>
		<RETURN>
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
        <COND (<EQUAL? ,HERE .LOC>
            <COND (<NOT .ACT>
                <TELL "[Bounty not accepted]">
            )(.COMP
                <TELL "[Bounty completed]">
            )
            (.RPT
                <TELL "[Bounty Reported. Will setup monsters.]">
                <ADD-BOUNTY .BOUNTY ,HERE>
            )(.INV
                <TELL "[Area investigated.]">
            )(.ACT
                <TELL "[Investigation ongoing. Setup clues.]">
				<ADD-CLUES .BOUNTY ,HERE>
            )>
            <CRLF><CRLF>
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
			<REMOVE ,TOPIC-NEKKER>
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

<ROUTINE NEED-TO-DISMOUNT ()
	<TELL "You need to dismount from " T ,CURRENT-VEHICLE " first!" CR>>

<ROUTINE NOTHING-HAPPENS ()
	<TELL "[Nothing happens.]" CR>>
