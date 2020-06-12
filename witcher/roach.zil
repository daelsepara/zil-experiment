<OBJECT ROACH
	(DESC "Roach")
	(SYNONYM HORSE STEED RIDE ROACH)
	(ADJECTIVE LOYAL FAITHFUL FAST)
	(ACTION ROACH-F)
	(NORTH PER ROACH-NORTH)
	(SOUTH PER ROACH-SOUTH)
	(EAST PER ROACH-EAST)
	(WEST PER ROACH-WEST)
	(FLAGS VEHBIT NARTICLEBIT PERSONBIT LIGHTBIT)>

<ROUTINE ROACH-F (RARG)
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<IN? ,PLAYER ,ROACH>
			<DESCRIBE-LOCATION-WHILE-RIDING <LOC ,ROACH>>
			<SEARCH-LOCATION <LOC ,ROACH>>
		)>
	)(ELSE
		<COND(<EQUAL? .RARG ,M-ENTER>
			<TELL "You galloped towards " D <LOC ,ROACH> CR CR>
			<SETG ,HERE <LOC ,ROACH>>
		)>
	)>>

<SYNTAX RIDE OBJECT (IN-ROOM ON-GROUND) (FIND VEHBIT) = V-RIDE>
<SYNONYM RIDE MOUNT>

<ROUTINE V-RIDE ()
	<COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<IN? ,PLAYER ,PRSO>
			<TELL "You are already riding the " D ,PRSO "." CR>
		)(ELSE
			<TELL "You ride the " D, PRSO "." CR>
			<MOVE ,PLAYER ,PRSO>
		)>
	)(ELSE
		<TELL "You can't ride the " D, PRSO "." CR>
	)>>

<SYNTAX UNMOUNT = V-UNMOUNT>
<SYNONYM UNMOUNT DISMOUNT>

<ROUTINE V-UNMOUNT ()
	<COND (<VERB? UNMOUNT>
		<COND (<IN? ,PLAYER ,ROACH>
			<MOVE ,PLAYER <LOC ,ROACH>>
			<TELL "You dismount from Roach." CR>
		)(ELSE
			<TELL "You are not riding Roach." CR>
		)>
	)>>

<SYNTAX ROACH = V-SUMMON>

<ROUTINE V-SUMMON ()
	<COND (<OR <EQUAL? <LOC ,PLAYER> <LOC ,ROACH>> <IN? ,PLAYER ,ROACH>>
		<TELL "Roach is already here." CR>
	)(ELSE
		<MOVE ,ROACH <LOC ,PLAYER>>
		<TELL "Whether a short time or long time passed, nobody knows; but by and by, Roach arrives." CR>
	)>>

<ROUTINE MOVE-ROACH (LOC)
	<COND (<NOT .LOC>
		<CANNOT-GO>
		<RFALSE>
	)(ELSE
		<MOVE ,ROACH .LOC>
		<RETURN ,ROACH>
	)>>
	
<ROUTINE ROACH-NORTH ()
	<MOVE-ROACH <GETP <LOC ,ROACH> P?NORTH>>>

<ROUTINE ROACH-SOUTH ()
	<MOVE-ROACH <GETP <LOC ,ROACH> P?SOUTH>>>

<ROUTINE ROACH-EAST ()
	<MOVE-ROACH <GETP <LOC ,ROACH> P?EAST>>>

<ROUTINE ROACH-WEST ()
	<MOVE-ROACH <GETP <LOC ,ROACH> P?WEST>>>
