<ROUTINE DETECT-OBJECTS (RARG "AUX" CURRENTOBJ)
	<COND (<==? .RARG ,M-LOOK>
		<COND (<FSET? ,WOLF-MEDALLION ,WORNBIT>
			<TELL <GETP ,HERE ,P?LDESC> CR>
			<SET CURRENTOBJ <FIRST? ,HERE>>
			<REPEAT ()
				<COND (<NOT .CURRENTOBJ>
					<RETURN>)
				(ELSE 
					<COND (<FSET? .CURRENTOBJ ,NDESCBIT>
						<TELL CR "Your medallion senses " D .CURRENTOBJ " here." CR>)>
				)>
				<SET CURRENTOBJ <NEXT? .CURRENTOBJ>>
			>)
		(ELSE
			<TELL <GETP ,HERE ,P?LDESC> CR>
		)>
	)>
>

<ROOM CAMP-SITE
	(LOC ROOMS)
	(DESC "Campsite")
	(LDESC "A small campfire is burning underneath a tree. All is quiet except for the crackling sound of burning wood. The fire keeps the wolves and other would-be predators at bay.")
	(ACTION DETECT-OBJECTS)
	(FLAGS RLANDBIT LIGHTBIT OUTSIDEBIT)>
