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

<ROUTINE CHECK-BOUNTY (ARGBOUNTY THISBOUNTY ARGGIVER)
    <COND (<AND ,PRSI <FSET? .THISBOUNTY ,BOUNTYBIT>>
        <COND (<NOT <EQUAL? .THISBOUNTY .ARGBOUNTY>>
            <TELL D .ARGGIVER " does not know anything about the " T .THISBOUNTY CR>
            <RFALSE>
        )>
        <RTRUE>
    )>
    <RTRUE>>

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ("AUX" KEY)
    <COND (<VERB? TALK>
        <COND (<IN? ,BOUNTY-WHITE-ORCHARD ,PLAYER>
            <COND (<GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-ACCEPTED>
                <COND (<NOT <CHECK-BOUNTY ,BOUNTY-WHITE-ORCHARD ,PRSI ,WHITE-ORCHARD-ALDERMAN>>
                    <RETURN>
                )>
                <COND (<NOT <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-INVESTIGATED>>
                    <TELL "You should probably continue investigating the " T <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-LOC> " area." CR>
                )(ELSE
                    <COND (<NOT <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-COMPLETED>>
                        <TELL "You have enough clues as the monster you are dealing with! Now is the time to deal with it!" CR>
                    )(ELSE
                        <TELL "Thanks, witcher! Our town is safe again! Here is your reward." CR>
                    )>
                )>
            )(ELSE
                <COND (<NOT <CHECK-BOUNTY ,BOUNTY-WHITE-ORCHARD ,PRSI ,WHITE-ORCHARD-ALDERMAN>>
                    <RETURN>
                )>
                <REPEAT ()
                    <CRLF>
                    <TELL D ,PRSO ":" CR>
                    <TELL "Are you here about the bounty (" T ,BOUNTY-WHITE-ORCHARD ")?" CR>
                    <TELL "1 - I'm here about the bounty." CR> 
                    <TELL "2 - I accept the bounty." CR>
                    <TELL "3 - Goodbye for now." CR>
                    <SET KEY <INPUT 1>>
                    <TALK-RESPONSE .KEY !\1 "The beast already claimed lots of victims.">
                    <COND (<EQUAL? .KEY !\2>
                        <ACCEPT-BOUNTY ,BOUNTY-WHITE-ORCHARD>
                        <RETURN>
                    )>
                    <COND (<EQUAL? .KEY !\3>
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
