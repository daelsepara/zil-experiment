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
	<COND (<AND <OR <GETP <LOC ,ROACH> ,P?THINGS> <GETP ,HERE ,P?THINGS>> <EQUAL? ,HAS-FOOD T>>
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
		<COND (<AND <GETP ,HERE ,P?THINGS> <NOT <FSET? ,HERE ,TOUCHBIT>>>
			<SETG ,HAS-FOOD T>
		)>
	)>>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(EAST TO FOREST)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(LDESC "Numerous Nilfgaardian and Temerian corpses are scattered everywhere. While some look like they have been cleaved, hacked, or bludgeoned, others seem to have been buried under the ground by magic.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM FOREST
	(LOC ROOMS)
	(DESC "Forest")
	(WEST TO CAMP-SITE)
	(LDESC "Dense thicket. The path west leads back to the camp site")
	(ACTION DETECT-OBJECTS)
	(THINGS (SOME) (FOOD MEAT RABBIT WOLVES WOLF) FOOD-F)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROUTINE FOOD-F ()
	<COND (<AND ,HAS-FOOD <VERB? TAKE>>
		<WITCHER-GATHER-FOOD <RANDOM ,FOOD-ABUNDANCE>>
		<SETG ,HAS-FOOD <>>
		<RTRUE>
	)>
>
