<OBJECT-TEMPLATE LOCATION =
	ROOM
		(NW TO PARTS-UNKNOWN)
		(NORTH TO PARTS-UNKNOWN)
		(NE TO PARTS-UNKNOWN)
		(WEST TO PARTS-UNKNOWN)
		(EAST TO PARTS-UNKNOWN)
		(SW TO PARTS-UNKNOWN)
		(SOUTH TO PARTS-UNKNOWN)
		(SE TO PARTS-UNKNOWN)
		(ACTION DETECT-OBJECTS)
		(LASTRESPAWN 0)
		(RESPAWN 0)>

<LOCATION DEEP-FOREST
	(LOC ROOMS)
	(DESC "Deep forest")
	(WEST TO EDGE-OF-FOREST)
	(LDESC "The thick foliage almost covers the entire area in shadows.")
	(MONSTER NEKKER)
	(RESPAWN 60)
	(THINGS
		NONE (FOOD MEAT) FOOD-F
		NONE (FOLIAGE TREE TREES AREA SHADOW SHADOWS FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<LOCATION EDGE-OF-FOREST
	(LOC ROOMS)
	(DESC "Forest")
	(WEST TO CAMP-SITE)
	(EAST TO DEEP-FOREST)
	(LDESC "A dense thicket forms at the edge of the clearing.")
	(THINGS
		NONE (FOOD MEAT) FOOD-F
		NONE (THICKET CLEARING EDGE PATH FOREST) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<LOCATION CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(EAST TO EDGE-OF-FOREST)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay.")
	(THINGS NONE (CAMPFIRE FIRE TREE TREES WOOD WOODS FOREST CAMP) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(WEST TO CROSSROADS)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. In one section of the field some of the victims appear to have been petrified and buried alive.")
	(THINGS (DEAD PETRIFIED NILFGAARDIAN TEMERIAN NILFGAARD TEMERIA) (CORPSE CORPSES FIELD VICTIM VICTIMS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION CROSSROADS
	(LOC ROOMS)
	(DESC "Cross Roads")
	(EAST TO BATTLE-FIELD)
	(WEST TO WHITE-ORCHARD-TOWN)
	(NW TO NORTH-OF-WHITE-ORCHARD)
	(LDESC "You are in what appears to be a major highway. Like many other infrasctures, whoever built this, must have cleared an entire forest. Other folk and animals that once sheltered there have long since moved on to find sanctuary elsewhere. Such things have become inevitable in humankind's inexorable march to progress.")
	(BOUNTY BOUNTY-WHITE-ORCHARD)
	(THINGS NONE (HIGHWAY FOREST PATH INFRASTRUCTURE INFRASTRUCTURES ROAD THINGS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-TOWN
	(LOC ROOMS)
	(DESC "White Orchard")
	(EAST TO CROSSROADS)
	(WEST TO WEST-OF-WHITE-ORCHARD)
	(NW TO WHITE-ORCHARD-HUT)
	(NORTH TO NORTH-OF-WHITE-ORCHARD)
	(LDESC "A small town bustling with activity.")
	(THINGS NONE (TOWN INHABITANTS PEOPLE) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION NORTH-OF-WHITE-ORCHARD
	(LOC ROOMS)
	(DESC "Northern Frontier")
	(NW TO WHITE-ORCHARD-FARM)
	(WEST TO WHITE-ORCHARD-HUT)
	(SOUTH TO WHITE-ORCHARD-TOWN)
	(SW TO WEST-OF-WHITE-ORCHARD)
	(SE TO CROSSROADS)
	(LDESC "All is quient on the nothern frontier. There is a shop here.")
	(THINGS NONE (FRONTIER) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WEST-OF-WHITE-ORCHARD
	(LOC ROOMS)
	(DESC "Western Frontier")
	(EAST TO WHITE-ORCHARD-TOWN)
	(NORTH TO WHITE-ORCHARD-HUT)
	(NE TO NORTH-OF-WHITE-ORCHARD)
	(SW TO EDGE-OF-BOG)
	(LDESC "Outside the town, everything is quiet again on the frontier.")
	(THINGS NONE (FRONTIER) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-HUT
	(LOC ROOMS)
	(DESC "Farmer's Hut")
	(NORTH TO WHITE-ORCHARD-FARM)
	(EAST TO NORTH-OF-WHITE-ORCHARD)
	(SOUTH TO WEST-OF-WHITE-ORCHARD)
	(SE TO WHITE-ORCHARD-TOWN)
	(LDESC "A quiet place, far from the crowd and the noise. There is a small hut here.")
	(THINGS NONE (HUT) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-FARM
	(LOC ROOMS)
	(DESC "Farm")
	(SOUTH TO WHITE-ORCHARD-HUT)
	(SE TO NORTH-OF-WHITE-ORCHARD)
	(LDESC "Several small enclosed plots of land are arranged neatly side by side, each having different crops. A lone scarecrow is at the center of the field. The crops are waiting to be harvested.")
	(BOUNTY BOUNTY-WHITE-ORCHARD-INFESTATION)
	(THINGS
		NONE (CROP CROPS FARM AREA PLOT SCARECROW) THINGS-F
		NONE (FOOD MEAT) FOOD-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<LOCATION EDGE-OF-BOG
	(LOC ROOMS)
	(DESC "Bog")
	(LDESC "At the edge of the bog, the water is murky and nearly impassable. What monsters lurk beyond?")
	(THINGS <> (BOG WATER) THINGS-F)
	(SW TO SWAMP)
	(NE TO WEST-OF-WHITE-ORCHARD)
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION SWAMP
	(LOC ROOMS)
	(DESC "Swamp")
	(NE TO EDGE-OF-BOG)
	(DOWN TO SWAMP-CAVE)
	(LDESC "Large tree roots twist and intertwine. The area is surrounded by a swamp. There appears to be a cave down here.")
	(THINGS <> (SWAMP BOG WATER TREES CAVE ROOTS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION SWAMP-CAVE
	(LOC ROOMS)
	(DESC "Cave entrance")
	(UP TO SWAMP)
	(DOWN TO CAVE-I)
	(LDESC "You are inside the cave near the entrance.")
	(THINGS <> (WALLS CAVE) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT ADJACENT)>

<LOCATION CAVE-I
	(LOC ROOMS)
	(DESC "Inside the cave")
	(UP TO SWAMP-CAVE)
	(SOUTH TO CAVE-II)
	(LDESC "You are inside the cave.")
	(THINGS <> (WALLS CAVE) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-II
	(LOC ROOMS)
	(DESC "Inside the cave")
	(NORTH TO CAVE-I)
	(SOUTH TO CAVE-LAIR)
	(LDESC "You are inside the cave.")
	(THINGS <> (WALLS CAVE) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-LAIR
	(LOC ROOMS)
	(DESC "Lair")
	(NORTH TO CAVE-II)
	(EAST TO CAVE-III)
	(LDESC "You are inside the lair of some beast.")
	(BOUNTY BOUNTY-CAVE-BEAR)
	(THINGS <> (WALLS CAVE LAIR) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-III
	(LOC ROOMS)
	(DESC "Inner Lair")
	(WEST TO CAVE-LAIR)
	(LDESC "You are deep inside the inner lair of the beast.")
	(UNLOCKED-BY BOUNTY-CAVE-BEAR)
	(ORENS 500)
	(THINGS <> (WALLS CAVE LAIR) THINGS-F)
	(FLAGS RLANDBIT ADJACENT INVISIBLE)>

<ROOM CANNOT-GO
	(LOC ROOMS)
	(DESC "Unknown")
	(ACTION CANNOT-GO-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT INVISIBLE)>

<ROOM PARTS-UNKNOWN
	(LOC ROOMS)
	(DESC "Unknown")
	(ACTION PARTS-UNKNOWN-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT INVISIBLE)>

<ROUTINE DETECT-OBJECTS (RARG)
	<NPC-SLEEP ,HERE>
	<COND (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-LOCATION ,HERE>
		<CHECK-FOOD-AVAILABILITY ,HERE>
		<CHECK-ORENS-AVAILABILITY ,HERE>
		<SEARCH-LOCATION ,HERE>
		<DESCRIBE-EXITS ,HERE>
	)(<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <CHECK-IF-UNLOCKED ,HERE>> <CANNOT-GO-F ,M-ENTER> <RTRUE>)>
		<SPAWN-BOUNTY ,HERE>
		<SPAWN-MONSTER ,HERE>
		<CHECK-TRAVEL-RESTRICTIONS ,HERE>
		<SETG ,LAST-LOC ,HERE>
	)(<EQUAL? .RARG ,M-END>
		<CHECK-ATTACKS-IN-THE-DARK ,HERE ,PLAYER>
	)>>

<ROUTINE FOOD-F ()
	<COND (<VERB? TAKE>
		<COND (<FSET? ,HERE ,HASFOOD>
			<WITCHER-GATHER-FOOD <RANDOM FOOD-ABUNDANCE>>
			<FCLEAR ,HERE ,HASFOOD>
		)(ELSE
			<TELL "You have already gathered everything." CR>
			<FLUSH>
		)>
		<RTRUE>
	)>
	<THINGS-F>>

<ROUTINE GO-BACK (TEXT)
	<FLUSH>
	<HLIGHT ,H-BOLD>
	<TELL CR .TEXT>
	<SETG HERE ,LAST-LOC>
	<MOVE ,PLAYER ,LAST-LOC>>

<ROUTINE CANNOT-GO-F (RARG)
	<COND (<EQUAL? .RARG ,M-ENTER>
		<GO-BACK "You cannot go that way.">
		<HLIGHT 0>
		<CRLF><CRLF>
	)>
	<RTRUE>>

<ROUTINE PARTS-UNKNOWN-F (RARG)
	<COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<FSET? ,LAST-LOC ,ADJACENT>
			<CANNOT-GO-F .RARG>
			<RTRUE>
		)>
		<GO-BACK <PICK-ONE EDGE-OF-THE-WORLD>>
		<TELL " You went back to " T ,LAST-LOC "." CR CR>
		<HLIGHT 0>
		<INPUT 1>
	)>
	<RTRUE>>

<ROUTINE THINGS-F ()
	<COND (<OR <VERB? LOOK-CLOSELY EXAMINE>>
		<TELL "You see " <PICK-ONE THING-DESCRIPTIONS> " about " D ,PRSO "." CR>
		<RTRUE>
	)>
	<RFALSE>>

<ROUTINE ORENS-F ("AUX" ORENS)
	<COND (<IS-DARK ,HERE ,PLAYER>
		<TELL "It is pitch black. You can't see a thing." CR>
		<FLUSH>
		<RTRUE>
	)>
	<COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TOPIC-ORENS>>
		<SET ORENS <GETP ,HERE ,P?ORENS>>
		<COND (<G? .ORENS 0>
			<SETG WITCHER-ORENS <+ ,WITCHER-ORENS .ORENS>>
			<TELL "You found " N .ORENS " Orens here" CR>
			<PUTP ,HERE ,P?ORENS NONE>
		)(ELSE
			<TELL "You found nothing." CR>
			<FLUSH>
		)>
		<RTRUE>
	)>>
