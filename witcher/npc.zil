<OBJECT WHITE-ORCHARD-ALDERMAN
    (IN WHITE-ORCHARD-TOWN)
    (DESC "The Alderman")
    (SYNONYM ALDERMAN)
    (ACTION WHITE-ORCHARD-ALDERMAN-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE V-TALK ()
    <COND(<FSET? ,PRSO ,PERSONBIT>
        <COND (<EQUAL? ,PRSO ,WITCHER ,PLAYER>
            <HMMM>
            <RTRUE>
        )>
        <TELL "You talk to " T ,PRSO>
        <COND (,PRSI
            <TELL " about " T ,PRSI>
        )>
        <CRLF>
        <COND (<EQUAL? ,PRSO ,ROACH>
            <TALK-HIGHLIGHT-PERSON ,ROACH "(She is just as ">
            <TELL <PICK-ONE ROACH-RESPONSES> " as you.)" CR>
        )>
    )(ELSE
        <TELL "Talking to " T, PRSO " is an amusing but pointless exercise." CR>
    )>>

<ROUTINE TALK-HIGHLIGHT-PERSON (PERSON TEXT)
    <HLIGHT ,H-BOLD>
	<TELL D .PERSON>
	<HLIGHT 0>
    <TELL ": " .TEXT>>

<ROUTINE TALK-RESPONSE (KEY CHOICE RESPONSE PERSON)
    <COND (<EQUAL? .KEY .CHOICE>
        <CRLF>
        <TALK-HIGHLIGHT-PERSON .PERSON .RESPONSE>
        <CRLF>
        <INPUT 1>
    )>>

<ROUTINE CHECK-BOUNTY (BOUNTY THISBOUNTY PERSON)
    <COND (.THISBOUNTY
        <COND (<FSET? .THISBOUNTY ,BOUNTYBIT>
            <COND (<NOT <EQUAL? .THISBOUNTY .BOUNTY>>
                <TELL D .PERSON " does not know anything about the " T .THISBOUNTY CR>
                <RFALSE>
            )>
            <RTRUE>
        )>
        <TALK-HIGHLIGHT-PERSON .PERSON "The what now?">
        <CRLF>
        <RFALSE>
    )>
    <RTRUE>>

<ROUTINE GENERIC-BOUNTY-DIALOG (PERSON BOUNTY)
    <COND (<NOT <GETP .BOUNTY P?BOUNTY-INVESTIGATED>>
        <TALK-HIGHLIGHT-PERSON .PERSON "You should probably continue investigating ">
        <TELL T <GETP .BOUNTY P?BOUNTY-LOC> " area." CR>
    )(ELSE
        <COND (<NOT <GETP .BOUNTY P?BOUNTY-REPORTED>>
            <TALK-HIGHLIGHT-PERSON .PERSON "You have enough clues about the monster you are dealing with! Now is the time to deal with it!">
            <PUTP .BOUNTY ,P?BOUNTY-REPORTED T>
        )(ELSE
            <COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
                <TALK-HIGHLIGHT-PERSON .PERSON "Please come back after you have dealt with the beast for your reward.">
            )(ELSE
                <TALK-HIGHLIGHT-PERSON .PERSON "Thanks, witcher! Our town is safe again!">
                <COND (<G? <GETP .BOUNTY ,P?BOUNTY-REWARD> 0>
                    <SETG ,WITCHER-ORENS <+ ,WITCHER-ORENS <GETP .BOUNTY ,P?BOUNTY-REWARD>>>
                    <TELL " Here is your reward. (" N <GETP .BOUNTY ,P?BOUNTY-REWARD> " Orens)">
                    <PUTP .BOUNTY ,P?BOUNTY-REWARD 0>
                )>
            )>
        )>
        <CRLF>
    )>>

<ROUTINE GENERIC-BOUNTY-TALK (BOUNTY PERSON TEXT "AUX" KEY)
    <COND (,RIDING-VEHICLE
        <NEED-TO-DISMOUNT>
        <RTRUE>
    )>
    <COND (<VERB? TALK>
        <CRLF>
        <COND (<NOT <EQUAL? ,PRSO .PERSON>>
            <TALK-HIGHLIGHT-PERSON .PERSON "You talking to me?">
            <CRLF>
            <RTRUE>
        )>
        <COND (<IN? .BOUNTY ,PLAYER>
            <COND (<GETP .BOUNTY P?BOUNTY-ACCEPTED>
                <COND (<NOT <CHECK-BOUNTY .BOUNTY ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <GENERIC-BOUNTY-DIALOG .PERSON .BOUNTY>
            )(ELSE
                <COND (<NOT <CHECK-BOUNTY .BOUNTY ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <STOP-EATING-CYCLE>
                <REPEAT ()
                    <TALK-HIGHLIGHT-PERSON .PERSON "">
                    <CRLF>
                    <TELL "Are you here about the bounty (" T .BOUNTY ")?" CR>
                    <TELL "1 - I'm here about the bounty." CR> 
                    <TELL "2 - I accept the bounty." CR>
                    <TELL "3 - Goodbye for now." CR>
                    <TELL "Your response: ">
                    <SET KEY <INPUT 1>>
                    <CRLF>
                    <TALK-RESPONSE .KEY !\1 .TEXT ,PRSO>
                    <COND (<EQUAL? .KEY !\2>
                        <ACCEPT-BOUNTY .BOUNTY ,PRSO>
                        <START-EATING-CYCLE>
                        <RETURN>
                    )(<EQUAL? .KEY !\3>
                        <CRLF>
                        <TALK-HIGHLIGHT-PERSON .PERSON "Bye!">
                        <CRLF>
                        <START-EATING-CYCLE>
                        <RETURN>
                    )>
                    <CRLF>
                    <CLOCKER>
                    <UPDATE-STATUS-LINE>
                >
            )>
        )(ELSE
            <TELL "Greetings!" CR>
        )>
    )(<VERB? EXAMINE LOOK-CLOSELY>
        <TELL "In most cultures it is rude to stare." CR>
    )>>

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ()
    <GENERIC-BOUNTY-TALK ,BOUNTY-WHITE-ORCHARD ,WHITE-ORCHARD-ALDERMAN "The beast already claimed lots of victims.">>
