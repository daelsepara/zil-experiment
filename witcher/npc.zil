<SYNTAX TALK TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-TALK>

<ROUTINE V-TALK ("AUX" PERSON)
    <COND(<FSET? ,PRSO ,PERSONBIT>
        <TELL "You talk to " T ,PRSO CR>
    )(ELSE
        <TELL "Talking to " T, PRSO " is an amusing but pointless exercise." CR>
    )>>

<OBJECT WHITE-ORCHARD-ALDERMAN
	(IN WHITE-ORCHARD-TOWN)
	(DESC "The Alderman")
    (SYNONYM ALDERMAN)
    (ACTION WHITE-ORCHARD-ALDERMAN-F)
	(FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ()
    <COND (<VERB? TALK>
        <COND (<IN? ,BOUNTY-WHITE-ORCHARD ,PLAYER>
            <COND (<GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-ACCEPTED>
            )(ELSE
                <TELL "Are you here about the bounty?" CR>
            )>
        )(ELSE
            <TELL "Greetings!" CR>
        )>
    )>>
