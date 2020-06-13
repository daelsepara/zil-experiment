<GLOBAL WITCHER-FOOD 20>
<GLOBAL WITCHER-HEALTH 1000>
<GLOBAL WITCHER-EAT-TURNS 6>

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
		<SETG WITCHER-FOOD <- ,WITCHER-FOOD 1>>
	)(ELSE
		<TELL "... feeling hungry, you decide to eat but you find that you do not have any food from your supplies." CR CR>
		<WITCHER-COMBAT-DAMAGE 100>
	)>>

<ROUTINE WITCHER-COMBAT-DAMAGE (AMT)
	<TELL "... you took " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-COMBAT>
	)>>

<ROUTINE WITCHER-HEALTH-DAMAGE (AMT)
	<TELL "... your fatigue costs you " N .AMT " points of damage." CR CR>
	<SETG WITCHER-HEALTH <- ,WITCHER-HEALTH .AMT>>
	<COND (<L? ,WITCHER-HEALTH 1>
		<DEATH-FATIGUE>
	)>>

<SYNTAX STATUS = V-WITCHER-STATUS>

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
	)>>
