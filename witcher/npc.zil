<SYNTAX TALK TO OBJECT (FIND PERSONBIT) (IN-ROOM) = V-TALK>
<SYNTAX TALK TO OBJECT (FIND PERSONBIT) (IN-ROOM) ABOUT OBJECT (FIND BOUNTYBIT) (HAVE HELD CARRIED) = V-TALK>

<ROUTINE V-TALK ()
    <COND(<FSET? ,PRSO ,PERSONBIT>
        <TELL "You talk to " T ,PRSO CR>
    )(ELSE
        <TELL "Talking to " T, PRSO " is an amusing but pointless exercise." CR>
    )>>

<ROUTINE TALK-RESPONSE (KEY CHOICE RESPONSE)
    <COND (<EQUAL? .KEY .CHOICE>
        <CRLF>
        <TELL .RESPONSE CR>
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
                <COND (<AND ,PRSI <FSET? ,PRSI ,BOUNTYBIT>>
                    <COND (<NOT <EQUAL? ,PRSI ,BOUNTY-WHITE-ORCHARD>>
                        <TELL D ,WHITE-ORCHARD-ALDERMAN " does not know anything about the " T ,PRSI CR>
                        <RTRUE>
                    )>
                )>
                <REPEAT ()
                    <CRLF>
                    <TELL D ,PRSO ":" CR>
                    <TELL "Are you here about the bounty?" CR>
                    <TELL "1 - Yes. I'm here about the "> 
                    <COND(<AND ,PRSI <FSET? ,PRSI ,BOUNTYBIT> <EQUAL? ,PRSI ,BOUNTY-WHITE-ORCHARD>>
                        <TELL T ,PRSI>
                    )(ELSE
                        <TELL "bounty">
                    )>
                    <TELL "." CR>
                    <TELL "2 - Goodbye for now." CR>
                    <SET KEY <INPUT 1>>
                    <TALK-RESPONSE .KEY !\1 "Excellent!">
                    <COND (<EQUAL? .KEY !\2>
                        <TELL CR D, PRSO ": Bye!" CR>
                        <RETURN>
                    )>
                >
            )>
        )(ELSE
            <TELL "Greetings!" CR>
        )>
    )(<VERB? EXAMINE CODEX>
        <TELL "In most cultures it is rude to stare." CR>
    )>>
