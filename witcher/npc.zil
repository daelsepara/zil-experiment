<SYNTAX TALK TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-TALK>
<SYNTAX TALK TO OBJECT (FIND PERSONBIT) (IN-ROOM) ABOUT OBJECT (FIND BOUNTYBIT) (HAVE HELD CARRIED) = V-TALK>


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

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ("AUX" KEY)
    <COND (<VERB? TALK>
        <COND (<IN? ,BOUNTY-WHITE-ORCHARD ,PLAYER>
            <COND (<GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-ACCEPTED>
            )(ELSE
                <TELL "Are you here about the bounty?" CR>
                <TELL "1. Yes. I'm here about the "> 
                <COND(<AND ,PRSI <FSET? ,PRSI ,BOUNTYBIT> <EQUAL? ,PRSI ,BOUNTY-WHITE-ORCHARD>>
                    <TELL T ,PRSI>
                )(ELSE
                    <TELL "bounty">
                )>
                <TELL "." CR>
                <SET KEY <INPUT 1>>
            )>
        )(ELSE
            <TELL "Greetings!" CR>
        )>
    )(<VERB? EXAMINE CODEX>
        <TELL "In most cultures it is rude to stare." CR>
    )>>
