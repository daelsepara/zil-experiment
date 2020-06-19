<ROOM DEEP-FOREST
	(LOC ROOMS)
	(DESC "Deep inside the forest")
	(WEST TO EDGE-OF-FOREST)
	(LDESC "The thick foliage almost covers the entire area in shadows.||The path west takes you out of the forest.")
	(ACTION DETECT-OBJECTS)
	(MONSTER NEKKER)
	(THINGS
		NONE (FOOD MEAT) FOOD-F
		NONE (FOLIAGE TREE TREES AREA SHADOW SHADOWS FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD NARTICLEBIT)>

<ROOM EDGE-OF-FOREST
	(LOC ROOMS)
	(DESC "Forest")
	(WEST TO CAMP-SITE)
	(EAST TO DEEP-FOREST)
	(LDESC "A dense thicket forms at the edge of the clearing.||The path west leads back to the camp. To the east lies the deep forest.")
	(ACTION DETECT-OBJECTS)
	(THINGS
		NONE (FOOD MEAT) FOOD-F
		NONE (THICKET CLEARING EDGE PATH FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(EAST TO EDGE-OF-FOREST)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay.||To the east lies the forest. To the west is an open field where a recent battle took place.")
	(ACTION DETECT-OBJECTS)
	(THINGS NONE (CAMPFIRE FIRE TREE TREES WOOD WOODS FOREST CAMP) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(WEST TO CROSSROADS)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. In one section of the field some of the victims appear to have been petrified and buried alive.||The camp site lies to the east.")
	(ACTION DETECT-OBJECTS)
	(THINGS (DEAD PETRIFIED NILFGAARDIAN TEMERIAN NILFGAARD TEMERIA) (CORPSE CORPSES FIELD VICTIM VICTIMS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM CROSSROADS
	(LOC ROOMS)
	(DESC "Cross Roads")
	(EAST TO BATTLE-FIELD)
	(WEST TO WHITE-ORCHARD-TOWN)
	(LDESC "You are in what appears to be a major highway. Like many other infrasctures, whoever built this, must have cleared an entire forest. Other folk and animals that once sheltered there have long since moved on to find sanctuary elsewhere. Such things have become inevitable in humankind's inexorable march to progress.||The road to the west leads to the town of White Orchard.")
	(ACTION DETECT-OBJECTS)
	(BOUNTY BOUNTY-WHITE-ORCHARD)
	(THINGS NONE (HIGHWAY FOREST PATH INFRASTRUCTURE INFRASTRUCTURES ROAD THINGS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM WHITE-ORCHARD-TOWN
	(LOC ROOMS)
	(DESC "White Orchard")
	(EAST TO CROSSROADS)
	(LDESC "A small town bustling with activity.")
	(ACTION DETECT-OBJECTS)
	(THINGS NONE (TOWN INHABITANTS PEOPLE) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROUTINE DETECT-OBJECTS (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-LOCATION ,HERE>
		<CHECK-FOOD-AVAILABILITY>
		<SEARCH-LOCATION ,HERE>
	)(<EQUAL? .RARG ,M-ENTER>
		<SPAWN-BOUNTY>
		<SETG ,LAST-LOC ,HERE>
		<SPAWN-MONSTER ,HERE>
		<CHECK-TRAVEL-FATIGUE>
	)>>

<ROUTINE FOOD-F ()
	<COND (<VERB? TAKE>
		<COND (<FSET? ,HERE ,HASFOOD>
			<WITCHER-GATHER-FOOD <RANDOM FOOD-ABUNDANCE>>
			<FCLEAR ,HERE ,HASFOOD>
		)(ELSE
			<TELL "You have already gathered everything." CR>
		)>
		<RTRUE>
	)>
	<THINGS-F>>

<ROUTINE THINGS-F ()
	<COND (<OR <VERB? LOOK-CLOSELY EXAMINE>>
		<TELL "You see " <PICK-ONE THING-DESCRIPTIONS> " about " D ,PRSO "." CR>
		<RTRUE>
	)>
	<RFALSE>>
