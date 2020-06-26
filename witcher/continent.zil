<OBJECT-TEMPLATE LOCATION =
	ROOM
		(NORTH TO PARTS-UNKNOWN)
		(WEST TO PARTS-UNKNOWN)
		(EAST TO PARTS-UNKNOWN)
		(SOUTH TO PARTS-UNKNOWN)
		(ACTION DETECT-OBJECTS)
		(MONSTER NONE)
		(LASTRESPAWN 0)
		(RESPAWN 0)
		(ORENS 0)
		(RANDOM-ORENS 0)
		(FLASHED FALSE)>

<LOCATION DEEP-FOREST
	(LOC ROOMS)
	(DESC "Deep forest")
	(WEST TO EDGE-OF-FOREST)
	(LDESC "Light struggles to penetrate through the thick foliage. This place perpetually engulf in shadows and gloom.")
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
	(NORTH TO BATTLE-FIELD-NORTH)
	(EAST TO CAMP-SITE)
	(WEST TO CROSSROADS)
	(SW TO SOUTH-CROSSROADS)
	(ORENS 50)
	(RANDOM-ORENS 10)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. Some of the victims appear to have been petrified and buried alive.")
	(THINGS (DEAD PETRIFIED NILFGAARDIAN TEMERIAN NILFGAARD TEMERIA) (CORPSE CORPSES FIELD VICTIM VICTIMS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION BATTLE-FIELD-NORTH
	(LOC ROOMS)
	(DESC "Battlefield, North")
	(LDESC "The desolation extends to this area. Dead bodies are everywhere. Carrion for the vultures. There is a camp nearby.")
	(SOUTH TO BATTLE-FIELD)
	(NE TO BANDIT-CAMP-I)
	(THINGS (DEAD) (CORPSE CORPSES DEAD BODY BODIES CARRION VULTURES) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION BANDIT-CAMP-I
	(LOC ROOMS)
	(DESC "Camp in the forest")
	(LDESC "It is a bandit's camp, also home to deserters and looters.")
	(SW BATTLE-FIELD-NORTH)
	(BOUNTY BOUNTY-BANDITS-I)
	(ORENS 100)
	(RANDOM-ORENS 20)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT ADJACENT)>

<LOCATION CROSSROADS
	(LOC ROOMS)
	(DESC "Crossroads")
	(EAST TO BATTLE-FIELD)
	(WEST TO WHITE-ORCHARD-TOWN)
	(NW TO NORTH-OF-WHITE-ORCHARD)
	(SOUTH TO SOUTH-CROSSROADS)
	(LDESC "You are in a major highway. Whoever built this must have cleared an entire forest. Other folk and animals that sheltered there have moved on to find sanctuary elsewhere. Such things have become inevitable in the march to progress.")
	(BOUNTY BOUNTY-WHITE-ORCHARD)
	(THINGS NONE (GROUND HIGHWAY FOREST PATH INFRASTRUCTURE INFRASTRUCTURES ROAD THINGS) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-TOWN
	(LOC ROOMS)
	(DESC "White Orchard")
	(EAST TO CROSSROADS)
	(WEST TO WEST-OF-WHITE-ORCHARD)
	(NW TO WHITE-ORCHARD-HUT)
	(NE TO BATTLE-FIELD)
	(NORTH TO NORTH-OF-WHITE-ORCHARD)
	(SOUTH TO WHITE-ORCHARD-INN)
	(LDESC "A small town bustling with activity. There is a nearby inn to the south.")
	(THINGS NONE (TOWN INHABITANTS PEOPLE) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-INN
	(LOC ROOMS)
	(DESC "White Orchard Inn")
	(NORTH TO WHITE-ORCHARD-TOWN)
	(EAST TO CANNOT-GO)
	(WEST TO CANNOT-GO)
	(SOUTH TO CANNOT-GO)
	(LDESC "A typical inn on the frontier.")
	(THINGS NONE (TOWN INHABITANTS PEOPLE) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT ADJACENT)>

<LOCATION SOUTH-CROSSROADS
	(LOC ROOMS)
	(DESC "Crossroads, South")
	(NORTH TO CROSSROADS)
	(SOUTH TO ABANDONED-VILLAGE)
	(LDESC "You are at the end of the highway. Further south leads to a village.")
	(MONSTER GHOULS)
	(LASTRESPAWN 60)
	(RESPAWN 120)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION ABANDONED-VILLAGE
	(LOC ROOMS)
	(DESC "abandoned village")
	(NORTH TO SOUTH-CROSSROADS)
	(EAST TO ABANDONED-VILLAGE-WELL)
	(LDESC "The viallge is quiet, almost abandoned. There is a well nearby.")
	(THINGS <> (GROUND) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION ABANDONED-VILLAGE-WELL
	(LOC ROOMS)
	(DESC "area outside the village")
	(WEST TO ABANDONED-VILLAGE)
	(DOWN TO ABANDONED-VILLAGE-WELL-BOTTOM)
	(LDESC "This is a small area, just outside the village where people must have gathered regularly.")
	(BOUNTY CONTRACT-GHOST-IN-THE-WELL)
	(THINGS <> (GROUND CORNER OUTSIDE TOWN) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT ADJACENT)>

<LOCATION ABANDONED-VILLAGE-WELL-BOTTOM
	(LOC ROOMS)
	(DESC "bottom of the well")
	(LDESC "The walls are damp. The air is rank with death.")
	(UNLOCKED-BY CONTRACT-GHOST-IN-THE-WELL)
	(NORTH TO CANNOT-GO)
	(SOUTH TO CANNOT-GO)
	(WEST TO CANNOT-GO)
	(EAST TO CANNOT-GO)
	(BOUNTY CONTRACT-MISSING-BRACELET)
	(UP TO ABANDONED-VILLAGE-WELL)
	(FLAGS RLANDBIT ADJACENT INVISIBLE)>

<LOCATION NORTH-OF-WHITE-ORCHARD
	(LOC ROOMS)
	(DESC "Northern Frontier")
	(NW TO WHITE-ORCHARD-FARM)
	(WEST TO WHITE-ORCHARD-HUT)
	(SOUTH TO WHITE-ORCHARD-TOWN)
	(SW TO WEST-OF-WHITE-ORCHARD)
	(SE TO CROSSROADS)
	(LDESC "All is quient on the nothern frontier. There is an alchemist' shop here.")
	(THINGS NONE (FRONTIER) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WEST-OF-WHITE-ORCHARD
	(LOC ROOMS)
	(DESC "Western Frontier")
	(EAST TO WHITE-ORCHARD-TOWN)
	(NORTH TO WHITE-ORCHARD-HUT)
	(NE TO NORTH-OF-WHITE-ORCHARD)
	(SW TO EDGE-OF-BOG)
	(LDESC "Everything is quiet on the western frontier.")
	(THINGS NONE (FRONTIER) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-HUT
	(LOC ROOMS)
	(DESC "Farmer's Hut")
	(NORTH TO WHITE-ORCHARD-FARM)
	(EAST TO NORTH-OF-WHITE-ORCHARD)
	(SOUTH TO WEST-OF-WHITE-ORCHARD)
	(SE TO WHITE-ORCHARD-TOWN)
	(LDESC "This place is far enough from the noise and the crowd. There is a small hut here.")
	(THINGS NONE (HUT) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION WHITE-ORCHARD-FARM
	(LOC ROOMS)
	(DESC "Farm")
	(SOUTH TO WHITE-ORCHARD-HUT)
	(SE TO NORTH-OF-WHITE-ORCHARD)
	(LDESC "Several plots of land are arranged pragmatically. On each plot is a different crop. A lone scarecrow is at the center. The farm looks ready for a harvest.")
	(BOUNTY BOUNTY-WHITE-ORCHARD-INFESTATION)
	(THINGS
		NONE (CROP CROPS FARM AREA PLOT SCARECROW) THINGS-F
		NONE (FOOD MEAT) FOOD-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<LOCATION EDGE-OF-BOG
	(LOC ROOMS)
	(DESC "Bog")
	(LDESC "The water is murky and nearly impassable.  What monsters lurk beyond?")
	(THINGS (MURKY) (BOG WATER) THINGS-F)
	(SW TO SWAMP)
	(NE TO WEST-OF-WHITE-ORCHARD)
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION SWAMP
	(LOC ROOMS)
	(DESC "Swamp")
	(NE TO EDGE-OF-BOG)
	(DOWN TO SWAMP-CAVE)
	(LDESC "Large tree roots twist and intertwine. The ground is constantly pushing back against the swamp.  There appears to be a cave down here.")
	(THINGS <> (SWAMP BOG WATER TREES CAVE ROOTS GROUND) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<LOCATION SWAMP-CAVE
	(LOC ROOMS)
	(DESC "Cave entrance")
	(UP TO SWAMP)
	(DOWN TO CAVE-I)
	(LDESC "Massive footprints lead in and out of the cave.")
	(THINGS <> (CAVE ENTRANCE PRINT) THINGS-F)
	(FLAGS RLANDBIT LIGHTBIT ADJACENT)>

<LOCATION CAVE-I
	(LOC ROOMS)
	(DESC "Inside the cave, near the entrance")
	(UP TO SWAMP-CAVE)
	(SOUTH TO CAVE-II)
	(LDESC "There are some claw marks on the walls. The footprints lead further to the south. Blood traces also head in that direction.")
	(THINGS <> (WALL WALLS CAVE FOOTPRINT FOOTPRINTS CLAW CLAWS MARKMARKS TRACE TRACES BLOOD) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-II
	(LOC ROOMS)
	(DESC "Inside the cave")
	(NORTH TO CAVE-I)
	(SOUTH TO CAVE-LAIR)
	(LDESC "Foul odorS emanates from the south. Excessive amounts of blood are splattered everywhere: on the floor and on the walls.")
	(THINGS <> (WALLS CAVE BLOOD FLOOR ODOR AIR WALL WALLS) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-LAIR
	(LOC ROOMS)
	(DESC "Lair")
	(NORTH TO CAVE-II)
	(EAST TO CAVE-III) 
	(LDESC "Bones and flesh remains of various creatures litter the floor. This is the lair of some beast.")
	(BOUNTY BOUNTY-CAVE-BEAR)
	(THINGS <> (BONES REMAINS WALLS CAVE LAIR CREATURE CREATURES FLOOR REMAINS) THINGS-F)
	(FLAGS RLANDBIT ADJACENT)>

<LOCATION CAVE-III
	(LOC ROOMS)
	(DESC "Inner Lair")
	(WEST TO CAVE-LAIR)
	(LDESC "The lair stops here. Everything here smells of death.")
	(UNLOCKED-BY BOUNTY-CAVE-BEAR)
	(ORENS 500)
	(RANDOM-ORENS 50)
	(THINGS <> (WALLS CAVE LAIR AIR) THINGS-F)
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
	<COND (<EQUAL? .RARG ,M-LOOK>
		<LOCATION-DESCRIPTIONS ,HERE>
		<PUTP ,HERE ,P?FLASHED FALSE>
	)(<EQUAL? .RARG ,M-BEG>
		<CRLF>
		<RFALSE>
	)(<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <CHECK-IF-UNLOCKED ,HERE>> <CANNOT-GO-F ,M-ENTER> <RTRUE>)>
		<SPAWN-BOUNTY ,HERE>
		<SPAWN-MONSTER ,HERE>
		<CHECK-TRAVEL-RESTRICTIONS ,HERE>
		<SETG ,LAST-LOC ,HERE>
	)(<EQUAL? .RARG ,M-END>
		<CHECK-ATTACKS-IN-THE-DARK ,HERE ,PLAYER>
	)(<EQUAL? .RARG ,M-FLASH>
		<COND (<NOT <GETP ,HERE ,P?FLASHED>>
			<PUTP ,HERE ,P?FLASHED T>
		)(ELSE
			<COND (<AND <FSET? ,HERE ,TOUCHBIT> <G? ,MOVES 0>>
				<LOCATION-DESCRIPTIONS ,HERE>
			)>
		)>
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

<ROUTINE LOCATION-DESCRIPTIONS (LOC)
	<DESCRIBE-EXITS .LOC>
	<CRLF>
	<DESCRIBE-LOCATION .LOC>
	<CHECK-FOOD-AVAILABILITY .LOC>
	<CHECK-ORENS-AVAILABILITY .LOC>
	<SEARCH-LOCATION .LOC>>

<ROUTINE ORENS-F ("AUX" ORENS RANDOM-ORENS SUM)
	<COND (<IS-DARK ,HERE ,PLAYER>
		<PITCH-BLACK>
		<RTRUE>
	)>
	<COND (<AND <VERB? TAKE> <EQUAL? ,PRSO ,TOPIC-ORENS>>
		<COND (<MONSTER-HERE> <NOT-THE-TIME> <RTRUE>)>
		<SET ORENS <GETP ,HERE ,P?ORENS>>
		<SET RANDOM-ORENS <GETP ,HERE ,P?RANDOM-ORENS>>
		<COND (<OR <G? .ORENS 0> <G? .RANDOM-ORENS 0>>
			<SET SUM .ORENS>
			<COND (<G? .RANDOM-ORENS 0>
				<SET .SUM <+ .SUM <RANDOM .RANDOM-ORENS>>>
			)>
			<SETG WITCHER-ORENS <+ ,WITCHER-ORENS .SUM>> 
			<TELL "You found " N .SUM " Orens here" CR>
			<COND (<G? .ORENS 0> <PUTP ,HERE ,P?ORENS NONE>)>
			<COND (<G? .RANDOM-ORENS 0> <PUTP ,HERE ,P?RANDOM-ORENS NONE>)>
		)(ELSE
			<TELL "You found nothing." CR>
			<FLUSH>
		)>
		<RTRUE>
	)>>

<ROUTINE THINGS-F ()
	<COND (<OR <VERB? LOOK-CLOSELY EXAMINE>>
		<TELL "You see " <PICK-ONE THING-DESCRIPTIONS> " about " D ,PRSO "." CR>
		<RTRUE>
	)>
	<RFALSE>>

<ROUTINE GO-BACK (TEXT)
	<FLUSH>
	<HLIGHT ,H-BOLD>
	<TELL .TEXT>
	<SETG HERE ,LAST-LOC>
	<MOVE ,PLAYER ,LAST-LOC>>

<ROUTINE CANNOT-GO-F (RARG)
	<COND (<EQUAL? .RARG ,M-ENTER>
		<GO-BACK "You cannot go that way.">
		<HLIGHT 0>
		<CRLF> <CRLF>
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
