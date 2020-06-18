<GLOBAL RIDING-VEHICLE <>>
<GLOBAL CURRENT-VEHICLE <>>

<OBJECT ROACH
	(DESC "Roach")
	(SYNONYM HORSE STEED RIDE ROACH)
	(ADJECTIVE LOYAL DEPENDABLE FAST)
	(ACTION ROACH-F)
	(FLAGS VEHBIT NARTICLEBIT PERSONBIT LIGHTBIT)>

<ROUTINE ROACH-F ()
	<COND (<AND <EQUAL? ,PRSA ,V?EXAMINE V?LOOK-CLOSELY> <EQUAL? ,PRSO ,ROACH>>
		<V-LOOK-CLOSELY>
		<RTRUE>
	)>>

<SYNTAX RIDE OBJECT (IN-ROOM ON-GROUND) (FIND VEHBIT) = V-RIDE>
<SYNONYM RIDE MOUNT>

<ROUTINE V-RIDE ()
	<COND (<FSET? ,PRSO ,VEHBIT>
		<COND (,RIDING-VEHICLE
			<TELL "You are already riding " T ,CURRENT-VEHICLE "." CR>
		)(ELSE
			<TELL "You ride " T ,PRSO "." CR>
			<SETG RIDING-VEHICLE T>
			<SETG CURRENT-VEHICLE ,PRSO>
		)>
	)(ELSE
		<COND (<FSET? ,PRSO ,TOPICBIT>
			<TELL "You can't see that here." CR>
		)(ELSE
			<TELL "You can't ride " T ,PRSO "." CR>
		)>
	)>>

<SYNTAX UNMOUNT = V-UNMOUNT>
<SYNONYM UNMOUNT DISMOUNT>

<ROUTINE V-UNMOUNT ()
	<COND (<VERB? UNMOUNT>
		<COND (,RIDING-VEHICLE
			
			<TELL "You dismount from " T, CURRENT-VEHICLE CR>

			<SETG RIDING-VEHICLE <>>
			<SETG CURRENT-VEHICLE <>>

			<MOVE ,TOPIC-ROACH <>>

		)(ELSE
			<TELL "You are not riding Roach." CR>
		)>
	)>>

<SYNTAX ROACH = V-SUMMON>

<ROUTINE V-SUMMON ()
	<COND (<EQUAL? <LOC ,PLAYER> <LOC ,ROACH>>
		<TELL "Roach is already here." CR>
	)(ELSE
		<MOVE ,ROACH <LOC ,PLAYER>>
		<MOVE ,TOPIC-ROACH <>>
		<TELL "Roach arrives. Whether a short time or long time passed, nobody knows." CR>
	)>>
