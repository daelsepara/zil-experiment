<OBJECT ROACH-META
	(IN LOCAL-GLOBALS)
	(DESC "Roach")
	(SYNONYM HORSE STEED RIDE ROACH)
	(ACTION GEAR-META-F)
	(FLAGS VEHBIT NARTICLEBIT PERSONBIT LIGHTBIT)>

<OBJECT ROACH
	(GLOBAL ROACH-META)
	(DESC "Roach")
	(SYNONYM HORSE STEED RIDE ROACH)
	(ADJECTIVE LOYAL DEPENDABLE FAST)
	(ACTION ROACH-F)
	(NORTH PER ROACH-NORTH)
	(SOUTH PER ROACH-SOUTH)
	(EAST PER ROACH-EAST)
	(WEST PER ROACH-WEST)
	(FLAGS VEHBIT NARTICLEBIT PERSONBIT LIGHTBIT)>

<ROUTINE ROACH-F (RARG)
	<COND (<AND <NOT <IN? ,PLAYER ,ROACH>> <VERB? EXAMINE>>
		<V-LOOK-CLOSELY>
		<RTRUE>
	)>
	<COND (<EQUAL? .RARG ,M-LOOK>
		<COND (<IN? ,PLAYER ,ROACH>
			<DESCRIBE-LOCATION-WHILE-RIDING <LOC ,ROACH>>
			<CHECK-FOOD-AVAILABILITY>
			<DESCRIBE-OBJECTS <LOC ,ROACH>>
			<SEARCH-LOCATION <LOC ,ROACH>>
		)>
	)(ELSE
		<COND(<EQUAL? .RARG ,M-ENTER>
			<TELL "You galloped towards the ..." CR CR>
			<SPAWN-MONSTER <LOC ,ROACH>>
			<SETG ,HERE <LOC ,ROACH>>
			<COND (<FIND-IN <LOC ,ROACH> ,MONSTERBIT>
				<FCLEAR ,DUMMY-MONSTER ,INVISIBLE>
			)>
		)>
	)>>

<SYNTAX RIDE OBJECT (IN-ROOM ON-GROUND) (FIND VEHBIT) = V-RIDE>
<SYNONYM RIDE MOUNT>

<ROUTINE V-RIDE ()
	<COND (<FSET? ,PRSO ,VEHBIT>
		<COND (<OR <IN? ,PLAYER ,PRSO> <FSET? <LOC ,PLAYER> ,VEHBIT>>
			<TELL "You are already riding " T ,PRSO "." CR>
		)(ELSE
			<TELL "You ride " T ,PRSO "." CR>
			<MOVE ,PLAYER ,PRSO>
			<COND (<FIND-IN <LOC ,PRSO> ,MONSTERBIT>
				<FCLEAR ,DUMMY-MONSTER ,INVISIBLE>
			)>
		)>
	)(ELSE
		<TELL "You can't ride " T ,PRSO "." CR>
	)>>

<SYNTAX UNMOUNT = V-UNMOUNT>
<SYNONYM UNMOUNT DISMOUNT>

<ROUTINE V-UNMOUNT ()
	<COND (<VERB? UNMOUNT>
		<COND (<IN? ,PLAYER ,ROACH>
			<MOVE ,PLAYER <LOC ,ROACH>>
			<TELL "You dismount from Roach." CR>
			<COND (<FIND-IN <LOC ,ROACH> ,MONSTERBIT>
				<FSET ,DUMMY-MONSTER ,INVISIBLE>
			)(ELSE
				<FCLEAR ,DUMMY-MONSTER ,INVISIBLE>
			)>
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
		<TELL "Roach arrives. Whether a short time or long time passed, nobody knows." CR>
	)>>

<ROUTINE MOVE-ROACH (DIR "AUX" LOC)
	<SET LOC <GETP <LOC ,ROACH> .DIR>>
	<COND (<NOT .LOC>
		<CANNOT-GO>
		<RFALSE>
	)(ELSE
		<MOVE ,ROACH .LOC>
		<RETURN ,ROACH>
	)>>

<ROUTINE ROACH-NORTH ()
	<MOVE-ROACH P?NORTH>>

<ROUTINE ROACH-SOUTH ()
	<MOVE-ROACH P?SOUTH>>

<ROUTINE ROACH-EAST ()
	<MOVE-ROACH P?EAST>>

<ROUTINE ROACH-WEST ()
	<MOVE-ROACH P?WEST>>
