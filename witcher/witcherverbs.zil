<ROUTINE V-ACCEPT-BOUNTY ()
	<WHAT-NOW>>

<ROUTINE V-APPLY-OIL ()
	<COND (<EQUAL? ,PRSI ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<EQUAL? ,PRSI ,SILVER-SWORD>
			<COND (<EQUAL? ,PRSO ,VAMPIRE-OIL ,SPECTER-OIL ,OGROID-OIL ,NECROPHAGE-OIL ,ELEMENTA-OIL ,HYBRID-OIL ,RELICT-OIL ,DRACONID-OIL ,CURSED-OIL>
				<REMOVE-AND-APPLY ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)(ELSE
			<COND (<EQUAL? ,PRSO ,HANGEDMANS-VENOM ,INSECTOID-OIL ,BEAST-OIL>
				<REMOVE-AND-APPLY ,PRSO ,PRSI>
			)(ELSE
				<CANNOT-APPLY-OIL ,PRSO ,PRSI>
			)>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE V-ATTACK-CHECK ()
	<COND (<IS-DARK ,HERE ,PLAYER>
		<TELL "It is pitch black. You can't see a thing." CR>
	)(ELSE
		<PERFORM ,V?ATTACK ,PRSO ,PRSI>
	)>>

<ROUTINE V-CLEAN-SWORD ()
	<CLEAN-SWORD ,PRSO>>

<ROUTINE V-COMBAT-MODE ()
	<COMBAT-MODE>>

<ROUTINE V-DESTROY ()
	<COND (<NOT <FSET? ,PRSO ,DESTRUCTIBLE>>
		<TELL "You can't destroy that!" CR>
	)(<NOT <FSET? ,PRSO ,NOTDESTROYED>>
		<TELL T , PRSO " was already destroyed. Nothing remains of it." CR>
	)(<L? ,WITCHER-BOMBS 1>
		<TELL "You have nothing to destory " T ,PRSO " with." CR>
	)(T
		<TELL "You dropped a bomb on " T ,PRSO " and retreat to a safe location. After some time it explodes, destroying " T, PRSO CR>
		<UPDATE-STATUS>
		<FCLEAR ,PRSO ,NOTDESTROYED>
		<SETG WITCHER-BOMBS <- ,WITCHER-BOMBS 1>>
	)>>

<ROUTINE V-EXAMINE-TOPIC ()
	<COND (<NOT <FSET? ,PRSO TOPICBIT>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>
	)>
	<TELL "You don't see that here." CR>>

<ROUTINE V-EXITS ()
	<DESCRIBE-EXITS ,HERE>>

<ROUTINE V-LOOK-CLOSELY ("AUX" TEXT)

	<COND (<EQUAL? ,PRSO ,PLAYER ,GERALT ,WITCHER>
		<HMMM>
		<RTRUE>
	)>
	
	<COND (<OR <IS-MONSTER ,PRSO> <FSET? ,PRSO ,TOPICBIT>> <TELL "You should read about " T ,PRSO " in the codex." CR> <RTRUE>)>

	<TELL "You looked at " T ,PRSO " closely and see that it is ">
	
	<SET TEXT <GETP ,PRSO ,P?TEXT>>

	<COND (.TEXT
		<TELL .TEXT CR>
		<RTRUE>
	)>

	<TELL "nothing special." CR>>

<ROUTINE V-LOOK-TOPIC ()
	<COND (<NOT <FSET? ,PRSO TOPICBIT>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>
	)>
	<TELL "You don't see that here." CR>>

<ROUTINE V-MEDITATE ()
	<COND (<MONSTER-HERE>
		<TELL CR "You cannot meditate when a monster is around!" CR>
		<RTRUE>
	)>
	<FLUSH>
	<WITCHER-REST>
	<TELL "You meditate .." CR>
	<TIME-PASSES WITCHER-MEDITATE-CYCLE>
	<TELL "[Some time passed]" CR CR>
	<V-LOOK>>

<ROUTINE V-READ-CODEX ()
	<READ-CODEX>>

<ROUTINE V-RELENTLESS-ASSAULT()
	<COND (<AND <FSET? ,PRSO ,MONSTERBIT> <FSET? ,PRSI ,WEAPONBIT>> <RELENTLESS-ASSAULT ,PRSO ,PRSI> <RTRUE>)>
	<COND (<NOT <MONSTER-HERE>> <TELL "There are no monsters to attack here." CR> <RFALSE>)>
	<COND (<OR <NOT <FIND-IN ,HERE ,WEAPONBIT>> <NOT <FIND-IN ,PLAYER ,WEAPONBIT>>> <TELL "You aren't carrying a weapon." CR> <RFALSE>)>
	<RFALSE>>
	
<ROUTINE V-REMOVE-OIL ()
	<COND (<EQUAL? ,PRSI ,SILVER-SWORD ,STEEL-SWORD>
		<COND (<FIRST? ,PRSI>
			<COND (<EQUAL? ,PRSO <FIRST? ,PRSI>>
				<TELL "You remove " T <FIRST? ,PRSI> " from " T ,PRSI CR>
				<MOVE <FIRST? ,PRSI> ,PLAYER>
			)(ELSE
				<TELL CT ,PRSO " has not been applied to " T ,PRSI CR>
			)>
		)(ELSE
			<TELL CT ,PRSI " is quite clean." CR>
		)>
	)(ELSE
		<NOTHING-HAPPENS>
	)>>

<ROUTINE V-REPORT-QUEST ()
	<WHAT-NOW>>

<ROUTINE V-RIDE ()
	<COND (<FSET? ,PRSO ,VEHBIT>
		<COND (,RIDING-VEHICLE
			<TELL "You are already riding " T ,CURRENT-VEHICLE "." CR>
		)(ELSE
			<TELL "You ride " T ,PRSO "." CR>
			<SETG RIDING-VEHICLE T>
			<SETG CURRENT-VEHICLE ,PRSO>
			<FSET ,CURRENT-VEHICLE ,NDESCBIT>
		)>
	)(ELSE
		<COND (<FSET? ,PRSO ,TOPICBIT>
			<TELL "You can't see that here." CR>
		)(ELSE
			<TELL "You can't ride " T ,PRSO "." CR>
		)>
	)>>

<ROUTINE V-SUMMON ()
	<COND (<NOT <FSET? ,HERE ,OUTSIDEBIT>>
		<NOTHING-HAPPENS>
		<RTRUE>
	)>
	<COND (<EQUAL? <LOC ,PLAYER> <LOC ,ROACH>>
		<COND (,RIDING-VEHICLE <TELL "You are currently riding " T ,CURRENT-VEHICLE>)
		(<AND ,PRSO <NOT <EQUAL? ,PRSO ,ROACH ,TOPIC-ROACH>>> <NOTHING-HAPPENS>)
		(<TELL "Roach is already here." CR>)>
	)(ELSE
		<COND (<AND ,PRSO <NOT <EQUAL? ,PRSO ,ROACH ,TOPIC-ROACH>>> <NOTHING-HAPPENS>  <RTRUE>)>
		<MOVE ,ROACH <LOC ,PLAYER>>
		<FCLEAR ,ROACH ,NDESCBIT>
		<TELL "Roach arrives. Whether a short time or long time passed, nobody knows." CR>
	)>>

<ROUTINE V-TALK ()
	<COND(<FSET? ,PRSO ,PERSONBIT>
		<COND (<EQUAL? ,PRSO ,WITCHER ,PLAYER ,GERALT>
			<HMMM>
			<RTRUE>
		)>
		<COND (<IS-MONSTER ,PRSO> <TELL T ,PRSO " can't be reasoned with!" CR> <RTRUE>)>
		<TELL "You talk to " T ,PRSO>
		<COND (,PRSI
			<TELL " about " T ,PRSI>
		)>
		<CRLF>
		<COND (<EQUAL? ,PRSO ,ROACH>
			<TALK-HIGHLIGHT-PERSON ,ROACH "(She is just as ">
			<TELL <PICK-ONE ROACH-RESPONSES> " as you.)" CR>
		)>
	)(ELSE
		<TELL "Talking to " T, PRSO " is an amusing but pointless exercise." CR>
	)>>

<ROUTINE V-UNMOUNT ()
	<COND (<VERB? UNMOUNT>
		<COND (,RIDING-VEHICLE
			<TELL "You dismount from " T, CURRENT-VEHICLE CR>
			<FCLEAR ,CURRENT-VEHICLE ,NDESCBIT>
			<SETG RIDING-VEHICLE FALSE>
			<SETG CURRENT-VEHICLE NONE>
		)(ELSE
			<TELL "You are not riding Roach." CR>
		)>
	)>>

<ROUTINE V-WAIT-CHECK ("AUX" MONSTER)
	<SET MONSTER <MONSTER-HERE ,HERE>>
	<COND (<NOT .MONSTER>
		<V-WAIT>
	)(<NOT <IS-DARK ,HERE ,PLAYER>>
		<MONSTER-ATTACKS .MONSTER>
	)>>

<ROUTINE V-WAIT-UNTIL ()
	<WAIT-UNTIL ,PRSO>>

<ROUTINE V-WITCHER-EAT ()
	<WITCHER-EAT>>

<ROUTINE V-WITCHER-JOURNAL ("AUX" QUEST-COUNT)
	<CRLF>
	<HLIGHT ,H-BOLD>
	<TELL "Quests and bounties: " CR CR>
	<HLIGHT 0>
	<SET QUEST-COUNT <LIST-QUESTS ,PLAYER>>
	<SET QUEST-COUNT <+ .QUEST-COUNT <LIST-QUESTS ,CONCEPT-JOURNAL>>>
	<COND (<0? .QUEST-COUNT> <TELL "None" CR>)>>

<ROUTINE V-WITCHER-SCORE ("AUX" QUEST-COUNT)
	<CRLF>
	<HLIGHT ,H-BOLD>
	<TELL "Score:" CR CR>
	<HLIGHT 0>
	<SET QUEST-COUNT <LIST-QUESTS ,PLAYER T>>
	<SET QUEST-COUNT <+ .QUEST-COUNT <LIST-QUESTS ,CONCEPT-JOURNAL T>>>
	<COND (<0? .QUEST-COUNT> <TELL "You have not completed any quests yet." CR>)(<TELL "Total Score: "> <HLIGHT ,H-BOLD> <TELL N ,SCORE CR> <HLIGHT 0>)>>

<ROUTINE V-WITCHER-STATUS ()
	<CRLF>
	<TELL "Health: " N ,WITCHER-HEALTH CR>
	<TELL "Food supplies: " N ,WITCHER-FOOD CR>
	<TELL "Orens: " N ,WITCHER-ORENS CR>
	<COND (<IN? ,SILVER-SWORD ,PLAYER>
		<TELL "Silver sword: ">
		<CHECK-SWORD-OIL ,SILVER-SWORD>
		<CHECK-SWORD-DMG ,SILVER-SWORD>
		<CRLF>
	)>
	<COND (<IN? ,STEEL-SWORD ,PLAYER>
		<TELL "Steel sword: ">
		<CHECK-SWORD-OIL ,STEEL-SWORD>
		<CHECK-SWORD-DMG ,STEEL-SWORD>
		<CRLF>
	)>
	<TELL "Bombs: " N ,WITCHER-BOMBS CR>
	<COND (<AND ,RIDING-VEHICLE ,CURRENT-VEHICLE>
		<TELL "You are currently riding " T ,CURRENT-VEHICLE CR>
	)(ELSE
		<COND (<IN? ,ROACH ,HERE>
			<TELL "Roach is here." CR>
		)>
	)>
	<CRLF>
	<COND (<EQUAL? ,DAYTIME T>
		<TELL "It is daytime." CR>
	)(ELSE
		<TELL "It is night." CR>
	)>>
