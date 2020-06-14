<ROUTINE DEATH-FATIGUE ()
	<JIGS-UP "In all your years killing monsters, you never expected that you could die from poor health." >>

<ROUTINE DEATH-COMBAT ()
	<JIGS-UP "In all your years killing monsters, you have not found something you could not overcome until today.">>

<ROUTINE I-WITCHER-EAT ()
	<WITCHER-EAT>
	<QUEUE I-WITCHER-EAT ,WITCHER-EAT-TURNS>>
	
<ROUTINE WITCHER-EAT ()
	<COND (<G? ,WITCHER-FOOD 0>
		<TELL "... feeling hungry, you decide to eat some food from your supplies." CR CR>
		<SETG WITCHER-FOOD <- ,WITCHER-FOOD ,WITCHER-CONSUMPTION>>
		<WITCHER-HEAL ,WITCHER-HEALING-RATE>
	)(ELSE
		<TELL "... feeling hungry, you decide to eat but you find that you do not have any food from your supplies." CR CR>
		<WITCHER-COMBAT-DAMAGE ,WITCHER-FATIGUE-RATE>
	)>>

<SYNTAX EAT = V-WITCHER-EAT>

<ROUTINE V-WITCHER-EAT ()
	<COND (<G? ,WITCHER-FOOD 0>
		<WITCHER-EAT>
		<DEQUEUE I-WITCHER-EAT>
		<QUEUE I-WITCHER-EAT ,WITCHER-EAT-TURNS>
	)(ELSE
		<TELL "... feeling hungry, you decide to eat but you find that you do not have any food from your supplies." CR CR>
	)>>

<ROUTINE WITCHER-GATHER-FOOD (AMT)
	<TELL "... you found " N .AMT " pieces of food for your supply." CR CR>
	<SETG WITCHER-FOOD <+ ,WITCHER-FOOD .AMT>>
>

<ROUTINE WITCHER-COMBAT-DAMAGE (AMT)
	<TELL "... you took " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-COMBAT>
	)>>

<ROUTINE WITCHER-HEALTH-DAMAGE (AMT)
	<TELL "... your fatigue hits you for " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-FATIGUE>
	)>>

<ROUTINE WITCHER-HEAL (AMT)
	<COND (<L? ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
		<TELL "... you heal " N .AMT " points." CR CR>
	)>
	<SETG WITCHER-HEALTH <+ ,WITCHER-HEALTH .AMT>>
	<COND (<G? ,WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
		<SETG WITCHER-HEALTH ,WITCHER-MAX-HEALTH>
	)>>

<SYNTAX STATUS = V-WITCHER-STATUS>
<SYNONYM STATUS INFO>

<ROUTINE V-WITCHER-STATUS ()
	<TELL "Health: " N ,WITCHER-HEALTH CR>
	<TELL "Food: " N ,WITCHER-FOOD CR>
	<COND (<IN? ,SILVER-SWORD ,PLAYER>
		<TELL "Silver sword: ">
		<COND (<FIRST? ,SILVER-SWORD>
			<TELL "with applied " D <FIRST? ,SILVER-SWORD>>
		)(ELSE
			<TELL "with no oils applied">
		)>
		<CRLF>
	)>
	<COND (<IN? ,STEEL-SWORD ,PLAYER>
		<TELL "Steel sword: ">
		<COND (<FIRST? ,STEEL-SWORD>
			<TELL "with applied " D <FIRST? ,STEEL-SWORD>>
		)(ELSE
			<TELL "with no oils applied">
		)>
		<CRLF>
	)>
	<COND (<IN? ,PLAYER ,ROACH>
		<TELL "You are currently riding Roach" CR>
	)(ELSE
		<COND (<IN? ,ROACH ,HERE>
			<TELL "Roach is here." CR>
		)>
	)>
	<CRLF>>

<SYNTAX ATTACK OBJECT (IN-ROOM) (FIND MONSTERBIT) WITH OBJECT (HAVE HELD CARRIED) (FIND WEAPONBIT) = V-ATTACK>
<SYNTAX HIT OBJECT (IN-ROOM) (FIND MONSTERBIT) WITH OBJECT (HAVE HELD CARRIED) (FIND WEAPONBIT) = V-ATTACK>
<SYNTAX FIGHT OBJECT (IN-ROOM) (FIND MONSTERBIT) WITH OBJECT (HAVE HELD CARRIED) (FIND WEAPONBIT) = V-ATTACK>

<ROUTINE WITCHER-ATTACK (ARGMONSTER ARGSWORD)
	<TELL "You attack the " D ,PRSO " with your " D ,PRSI CR>
	<TELL "It has " N <GETP ,PRSO P?HIT-POINTS> " hit points left " CR>>

<ROUTINE WEAPON-INEFFECTIVE (ARGMONSTER ARGSWORD)
	<TELL "The " D .ARGSWORD " hits the " D .ARGMONSTER " with a dull sound." CR>   
	<TELL "Your " D .ARGSWORD " is not effective against the " D .ARGMONSTER "." CR>>

<ROUTINE NO-COMBAT-PLAN (ARGMONSTER ARGWEAPON)
	<TELL "That is your plan? Attacking the " D .ARGMONSTER " with the " D .ARGWEAPON "?" CR>>

<ROUTINE MONSTER-RESPONSE (ARGMONSTER)
	<TELL "This " D .ARGMONSTER " does not respond to anything else." CR>>

<ROUTINE COMBAT-SILVER (ARGMONSTER ARGWEAPON)
	<COND (<NOT .ARGWEAPON>
		<TELL "Not using any weapon isn't going to help you in this situation." CR>
	)(ELSE
		<COND (<FSET? .ARGWEAPON ,WEAPONBIT>
			<COND (<EQUAL? .ARGWEAPON ,SILVER-SWORD>
				<WITCHER-ATTACK .ARGMONSTER .ARGWEAPON>
			)(ELSE
				<WEAPON-INEFFECTIVE .ARGMONSTER .ARGWEAPON>
			)>
		)(ELSE
			<NO-COMBAT-PLAN .ARGMONSTER .ARGWEAPON>
		)>
	)>>

<ROUTINE COMBAT-STEEL (ARGMONSTER ARGWEAPON)
	<COND (<NOT .ARGWEAPON>
		<TELL "Not using any weapon isn't going to help you in this situation." CR>
	)(ELSE
		<COND (<FSET? .ARGWEAPON ,WEAPONBIT>
			<COND (<EQUAL? .ARGWEAPON ,STEEL-SWORD>
				<WITCHER-ATTACK .ARGMONSTER .ARGWEAPON>
			)(ELSE
				<WEAPON-INEFFECTIVE .ARGMONSTER .ARGWEAPON>
			)>
		)(ELSE
			<NO-COMBAT-PLAN .ARGMONSTER .ARGWEAPON>
		)>
	)>>