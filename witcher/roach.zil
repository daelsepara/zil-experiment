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
