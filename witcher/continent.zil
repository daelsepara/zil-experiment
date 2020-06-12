<ROUTINE SEARCH-LOCATION (LOC "AUX" CURRENTOBJ)
	<COND (<AND <FSET? ,WOLF-MEDALLION ,WEARBIT> <FSET? ,WOLF-MEDALLION ,WORNBIT>>
		<SET CURRENTOBJ <FIRST? .LOC>>
		<REPEAT ()
			<COND (<NOT .CURRENTOBJ>
				<RETURN>
			)(ELSE 
				<COND (<FSET? .CURRENTOBJ ,NDESCBIT>
					<COLOR 1 2>
					<TELL CR "Your medallion senses the presence of a ">
					<COLOR 9 6>
					<HLIGHT ,H-BOLD>
					<TELL D .CURRENTOBJ>
					<HLIGHT 0>
					<COLOR 1 2>
					<TELL " here." CR>
				)>
			)>
			<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
		>
	)>>

<ROUTINE DETECT-OBJECTS (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<AND <FSET? ,WOLF-MEDALLION ,WEARBIT> <FSET? ,WOLF-MEDALLION ,WORNBIT>>
			<DESCRIBE-LOCATION ,HERE>
		)>
		<SEARCH-LOCATION ,HERE>
	)(<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <IN? ,PLAYER ,ROACH>>
			<TELL "A long time passed before you arrived." CR CR>
		)>
	)>>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(WEST TO BATTLE-FIELD)
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at bay.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>

<ROOM BATTLE-FIELD
	(LOC ROOMS)
	(DESC "Battlefield")
	(EAST TO CAMP-SITE)
	(LDESC "Numerous Nilfgaard and Temerian corpses are scattered everywhere. While some look like they have been cleaved, hacked, or bludgeoned, others seem to have been buried under the ground by magic.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>
