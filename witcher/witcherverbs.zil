"
0 - Accepted
1 - Investigated
2 - Reported
3 - Completed
"
<ROUTINE D-ACCEPTED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 0>>

<ROUTINE D-COMPLETED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 3>>

<ROUTINE D-INVESTIGATED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 1>>

<ROUTINE D-REPORTED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 2>>

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

<ROUTINE V-CLEAN-SWORD ()
	<CLEAN-SWORD ,PRSO>>

<ROUTINE V-COMBAT-MODE ("AUX" MONSTER (WEAPON NONE) KEY)
	<SET MONSTER <FIND-IN ,HERE ,MONSTERBIT>>
	<COND (.MONSTER
		<COND (,RIDING-VEHICLE
			<NEED-TO-DISMOUNT>
			<RTRUE>
		)>
		<COND (<AND <NOT <FSET? ,HERE ,LIGHTBIT>> <NOT <FIND-IN ,PLAYER ,LIGHTBIT>> <NOT <FIND-IN ,HERE ,LIGHTBIT>> .MONSTER>
			<TELL "You cannot enter combat!" CR>
			<FLUSH>
			<RTRUE>
		)>
		<FLUSH>
		<SET WEAPON <CHOOSE-WEAPON .MONSTER>>
		<REPEAT ()
			<CRLF>
			<TELL "What do you want to do next?" CR>
			<TELL "1 - Attack monster!" CR>
			<TELL "2 - Eat food" CR>
			<TELL "3 - Change my weapon" CR>
			<TELL "4 - Check my status" CR>
			<TELL "5 - Retreat!" CR>
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
			<COND (<EQUAL? .KEY !\5> <CRLF> <TELL "You withdraw from combat!" CR> <RETURN>)>
			<CLOCKER>
			<UPDATE-STATUS-LINE>
		>
	)(ELSE
		<TELL "There are no monsters here!" CR>
	)>>

<ROUTINE V-DESTROY ()
	<COND (<NOT <FSET? ,PRSO ,DESTRUCTIBLE>>
		<TELL "You can't destroy that!" CR>
	)(<NOT <FSET? ,PRSO ,NOTDESTROYED>>
		<TELL T , PRSO " was already destroyed. Nothing remains of it." CR>
	)(<L? ,WITCHER-BOMBS 1>
		<TELL "You have nothing to destory " T ,PRSO " with." CR>
	)(T
		<TELL "You dropped a bomb on " T ,PRSO " and retreat to a safe location. After some time it explodes, destroying " T, PRSO CR>
		<CLOCKER>
		<FCLEAR ,PRSO ,NOTDESTROYED>
		<SETG WITCHER-BOMBS <- ,WITCHER-BOMBS 1>>
	)>>

<ROUTINE V-EXAMINE-TOPIC ()
	<COND (<NOT <FSET? ,PRSO TOPICBIT>>
		<PERFORM ,V?LOOK-CLOSELY ,PRSO>
		<RTRUE>
	)>
	<TELL "You don't see that here." CR>>

<ROUTINE V-EXITS ()
	<DESCRIBE-EXITS ,HERE>>

<ROUTINE V-LOOK-CLOSELY ()
	<COND (<EQUAL? ,PRSO ,PLAYER ,GERALT ,WITCHER>
		<HMMM>
		<RTRUE>
	)>
	
	<COND (<FSET? ,PRSO ,MONSTERBIT> <TELL "You should read about " D ,PRSO " in the codex." CR> <RTRUE>)>

	<TELL "You looked at " T ,PRSO " closely and see that it is ">
	
	<COND
		(<EQUAL? ,PRSO ,ROACH>
			<TELL "a loyal and dependable horse that sometimes ends up in odd places." CR>
			<RTRUE>)
		
		(<EQUAL? ,PRSO ,SILVER-SWORD>
			<TELL "a weapon for killing creatures of magic." CR>
			<RTRUE>)
			
		(<EQUAL? ,PRSO ,STEEL-SWORD>
			<TELL "a weapon for killing humans or humanoid creatures and beasts." CR>
			<RTRUE>)
		
		(<EQUAL? ,PRSO ,VAMPIRE-OIL ,SPECTER-OIL ,OGROID-OIL ,NECROPHAGE-OIL ,ELEMENTA-OIL ,HYBRID-OIL ,RELICT-OIL ,DRACONID-OIL ,CURSED-OIL ,HANGEDMANS-VENOM ,INSECTOID-OIL ,BEAST-OIL>
			<TELL "a type of oil for dealing with specific kinds of monsters." CR>
			<RTRUE>)
		
		(<EQUAL? ,PRSO ,WOLF-MEDALLION>
			<TELL "an amulet that can detect the presence of magic." CR>
			<RTRUE>)>

	<TELL "nothing special." CR>>

<ROUTINE V-LOOK-TOPIC ()
	<COND (<NOT <FSET? ,PRSO TOPICBIT>>
		<PERFORM ,V?EXAMINE ,PRSO>
		<RTRUE>
	)>
	<TELL "You don't see that here." CR>>

<ROUTINE V-MEDITATE ()
	<COND (<FIND-IN ,HERE ,MONSTERBIT>
		<TELL CR "You cannot meditate when a monster is around!" CR>
		<RTRUE>
	)>
	<FLUSH>
	<COND(,RIDING-VEHICLE <PERFORM ,V?UNMOUNT>)>
	<TELL "You meditate .." CR>
	<DEQUEUE I-OIL-IN-SILVER-DEPLETES>
	<DEQUEUE I-OIL-IN-STEEL-DEPLETES>
	<TIME-PASSES WITCHER-MEDITATE-CYCLE>
	<CLEAN-SWORD ,SILVER-SWORD T>
	<CLEAN-SWORD ,STEEL-SWORD T>
	<SETG ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
	<TELL "[Some time passed]" CR CR>
	<V-LOOK>>

<ROUTINE V-READ-CODEX ()
	<READ-CODEX>>

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
		<COND (<FSET? ,PRSO ,MONSTERBIT> <TELL "The monster can't be reasoned with!" CR> <RTRUE>)>
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
			<SETG RIDING-VEHICLE NONE>
			<SETG CURRENT-VEHICLE NONE>
		)(ELSE
			<TELL "You are not riding Roach." CR>
		)>
	)>>

<ROUTINE V-WITCHER-EAT ()
	<WITCHER-EAT>>

<ROUTINE V-WITCHER-STATUS ()
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
	<COND (<EQUAL? ,DAYTIME T>
		<TELL "It is daytime." CR>
	)(ELSE
		<TELL "It is night." CR>
	)>>
