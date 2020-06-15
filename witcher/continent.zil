<ROUTINE SEARCH-LOCATION (LOC "AUX" CURRENTOBJ)
	<COND (<AND <FSET? ,WOLF-MEDALLION ,WEARBIT> <FSET? ,WOLF-MEDALLION ,WORNBIT>>
		<SET CURRENTOBJ <FIRST? .LOC>>
		<REPEAT ()
			<COND (<NOT .CURRENTOBJ>
				<RETURN>
			)(ELSE 
				<COND (<FSET? .CURRENTOBJ ,MAGICBIT>
					<TELL CR "Your medallion senses the presence of a ">
					<HLIGHT ,H-INVERSE>
					<TELL D .CURRENTOBJ>
					<HLIGHT 0>
					<TELL " here." CR>
				)>
			)>
			<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
		>
	)>>

<ROUTINE CHECK-FOOD-AVAILABILITY ()
	<COND (<OR <FSET? <LOC ,ROACH> ,HASFOOD> <FSET? ,HERE ,HASFOOD>>
		<TELL "... you can probably get some food here." CR>
	)>>

<ROUTINE RESET-MONSTER (ARGMONSTER ARGHP LOC)
	<PUTP .ARGMONSTER P?HIT-POINTS .ARGHP>
	<MOVE .ARGMONSTER .LOC>>

<ROUTINE SPAWN-MONSTER (LOC "AUX" MONSTER)
	<SET MONSTER <GETP .LOC ,P?MONSTER>>
	<COND (.MONSTER
		<COND (<EQUAL? .MONSTER NEKKER>
			<RESET-MONSTER ,NEKKER HP-NEKKER .LOC>
		)(<EQUAL? .MONSTER BANDITS>
			<RESET-MONSTER ,BANDITS HP-BANDITS .LOC>
		)>
		<RETURN>
	)>>

<ROUTINE DETECT-OBJECTS (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-LOCATION ,HERE>
		<CHECK-FOOD-AVAILABILITY>
		<SEARCH-LOCATION ,HERE>
	)(<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <IN? ,PLAYER ,ROACH>>
			<SPAWN-MONSTER ,HERE>
			<TELL "A long time passed before you arrived." CR CR>
			<WITCHER-HEALTH-DAMAGE ,WITCHER-FATIGUE-RATE "fatigue">
		)>
	)>>

<ROUTINE THINGS-F ()
	<COND (<EQUAL? ,PRSA ,V?LOOK ,V?CODEX>
		<TELL "You see nothing special about " D ,PRSO "." CR>
		<RTRUE>
	)(ELSE
		<RFALSE>
	)>>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(EAST TO EDGE-OF-FOREST)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay. To the east lies the forest. To the west is an open field where a recent battle took place.")
	(ACTION DETECT-OBJECTS)
	(THINGS
		<> (CAMPFIRE FIRE TREE TREES WOOD WOODS FOREST CAMP) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. In one section of the field, some of corpses appear to have been petrified. The camp site lies to the east.")
	(ACTION DETECT-OBJECTS)
	(THINGS
		(DEAD PETRIFIED NILFGAARDIAN TEMERIAN NILFGAARD TEMERIA) (CORPSE CORPSES FIELD) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM EDGE-OF-FOREST
	(LOC ROOMS)
	(DESC "Forest")
	(WEST TO CAMP-SITE)
	(EAST TO DEEP-FOREST)
	(LDESC "A dense thicket forms at the edge of the clearing. The path west leads back to the camp. To the east lies the deep forest.")
	(ACTION DETECT-OBJECTS)
	(THINGS
		<> (FOOD MEAT) FOOD-F
		<> (THICKET CLEARING EDGE PATH FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<ROOM DEEP-FOREST
	(LOC ROOMS)
	(DESC "Deep inside the forest")
	(WEST TO EDGE-OF-FOREST)
	(LDESC "The thick foliage almost covers the entire area in shadows. The path west takes you out of the forest.")
	(ACTION DETECT-OBJECTS)
	(MONSTER NEKKER)
	(THINGS
		<> (FOOD MEAT) FOOD-F
		<> (FOLIAGE TREE TREES AREA SHADOW SHADOWS FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<ROUTINE FOOD-F ()
	<COND (<VERB? TAKE>
		<COND (<FSET? ,HERE ,HASFOOD>
			<WITCHER-GATHER-FOOD <RANDOM ,FOOD-ABUNDANCE>>
			<FCLEAR ,HERE ,HASFOOD>
			<RTRUE>
		)(ELSE
			<TELL "You have already gathered everything." CR>
			<RTRUE>
		)>
	)>
	<THINGS-F>>
