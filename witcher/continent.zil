<ROUTINE SEARCH-LOCATION (LOC "AUX" CURRENTOBJ)
	<COND (<AND <FSET? ,WOLF-MEDALLION ,WEARBIT> <FSET? ,WOLF-MEDALLION ,WORNBIT>>
		<SET CURRENTOBJ <FIRST? .LOC>>
		<REPEAT ()
			<COND (<NOT .CURRENTOBJ>
				<RETURN>
			)(ELSE 
				<COND (<FSET? .CURRENTOBJ ,NDESCBIT>
					<TELL CR "Your medallion senses the presence of a ">
					<HLIGHT ,H-BOLD>
					<TELL D .CURRENTOBJ>
					<HLIGHT 0>
					<TELL " here." CR>
				)>
			)>
			<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
		>
	)>>

<ROUTINE CHECK-FOOD-AVAILABILITY ()
	<COND (<AND <OR <GETP <LOC ,ROACH> ,P?THINGS> <GETP ,HERE ,P?THINGS>> <OR <FSET? <LOC ,ROACH> ,HASFOOD> <FSET? ,HERE ,HASFOOD>>>
		<TELL "... you probably can get some food here." CR CR>
	)>>
		
<ROUTINE DETECT-OBJECTS (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<DESCRIBE-LOCATION ,HERE>
		<CHECK-FOOD-AVAILABILITY>
		<SEARCH-LOCATION ,HERE>
	)(<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <IN? ,PLAYER ,ROACH>>
			<TELL "A long time passed before you arrived." CR CR>
			<WITCHER-HEALTH-DAMAGE ,WITCHER-FATIGUE-RATE>
		)>
	)>>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(EAST TO FOREST)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay. To the east lies the forest. To the west is an open field where a recent battle took place.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. While some look like they have been cleaved, hacked, or bludgeoned, others seem to have been buried under the ground by magic. Your camp site is lies east.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM FOREST
	(LOC ROOMS)
	(DESC "Forest")
	(WEST TO CAMP-SITE)
	(LDESC "Dense thicket. The path west leads back to the camp site")
	(ACTION DETECT-OBJECTS)
	(THINGS (SOME) (FOOD MEAT RABBIT WOLVES WOLF) FOOD-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT HASFOOD)>

<ROUTINE FOOD-F ()
	<COND (<AND <FSET? ,HERE ,HASFOOD> <VERB? TAKE>>
		<WITCHER-GATHER-FOOD <RANDOM ,FOOD-ABUNDANCE>>
		<FCLEAR ,HERE ,HASFOOD>
		<RTRUE>
	)>
>
