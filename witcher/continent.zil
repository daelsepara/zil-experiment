<ROUTINE DETECT-OBJECTS (RARG "AUX" CURRENTOBJ)
	<COND (<EQUAL? .RARG ,M-LOOK ,M-ENTER>
		<DESCRIBE-LOCATION ,HERE>
		<COND (<FSET? ,WOLF-MEDALLION ,WORNBIT>
			<SET CURRENTOBJ <FIRST? ,HERE>>
			<REPEAT ()
				<COND (<NOT .CURRENTOBJ>
					<RETURN>
				)(ELSE 
					<COND (<FSET? .CURRENTOBJ ,NDESCBIT>
						<TELL CR "Your medallion senses the presence of a " D .CURRENTOBJ " here." CR>
					)>
				)>
				<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
			>
		)>
	)>>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sound of burning wood. The fire keeps the wolves and other would-be predators at bay.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>
