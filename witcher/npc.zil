<SYNTAX ASK OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNONYM SPEAK CHAT>

<CONSTANT ROACH-RESPONSES <LTABLE 2 "clueless" "amused" "fascinated" "bored" "interested" "enthusiastic">>

<ROUTINE V-TALK ()
    <COND(<FSET? ,PRSO ,PERSONBIT>
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

<ROUTINE TALK-HIGHLIGHT-PERSON (ARGPERSON ARGTEXT)
    <HLIGHT ,H-BOLD>
	<TELL D .ARGPERSON>
	<HLIGHT 0>
    <TELL ": " .ARGTEXT>>

<ROUTINE TALK-RESPONSE (KEY CHOICE RESPONSE ARGPERSON)
    <COND (<EQUAL? .KEY .CHOICE>
        <CRLF>
        <TALK-HIGHLIGHT-PERSON .ARGPERSON .RESPONSE>
        <CRLF>
        <INPUT 1>
    )>>

<OBJECT WHITE-ORCHARD-ALDERMAN
    (IN WHITE-ORCHARD-TOWN)
    (DESC "The Alderman")
    (SYNONYM ALDERMAN)
    (ACTION WHITE-ORCHARD-ALDERMAN-F)
    (FLAGS PERSONBIT NARTICLEBIT)>

<ROUTINE CHECK-BOUNTY (ARGBOUNTY THISBOUNTY ARGGIVER)
    <COND (.THISBOUNTY
        <COND (<FSET? .THISBOUNTY ,BOUNTYBIT>
            <COND (<NOT <EQUAL? .THISBOUNTY .ARGBOUNTY>>
                <TELL D .ARGGIVER " does not know anything about the " T .THISBOUNTY CR>
                <RFALSE>
            )>
            <RTRUE>
        )>
        <TALK-HIGHLIGHT-PERSON .ARGGIVER "The what now?">
        <CRLF>
        <RFALSE>
    )>
    <RTRUE>>

<ROUTINE WHITE-ORCHARD-ALDERMAN-F ("AUX" KEY)
    <COND (<VERB? TALK>
        <CRLF>
        <COND (<NOT <EQUAL? ,PRSO ,WHITE-ORCHARD-ALDERMAN>>
            <TALK-HIGHLIGHT-PERSON ,WHITE-ORCHARD-ALDERMAN "You talking to me?">
            <CRLF>
            <RTRUE>
        )>
        <COND (<IN? ,BOUNTY-WHITE-ORCHARD ,PLAYER>
            <COND (<GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-ACCEPTED>
                <COND (<NOT <CHECK-BOUNTY ,BOUNTY-WHITE-ORCHARD ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <COND (<NOT <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-INVESTIGATED>>
                    <TALK-HIGHLIGHT-PERSON ,PRSO "You should probably continue investigating ">
                    <TELL T <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-LOC> " area." CR>
                )(ELSE
                    <COND (<NOT <GETP ,BOUNTY-WHITE-ORCHARD P?BOUNTY-COMPLETED>>
                        <TALK-HIGHLIGHT-PERSON ,PRSO "You have enough clues as the monster you are dealing with! Now is the time to deal with it!">
                        <CRLF>
                    )(ELSE
                        <TALK-HIGHLIGHT-PERSON ,PRSO "Thanks, witcher! Our town is safe again! Here is your reward.">
                        <CRLF>
                    )>
                )>
            )(ELSE
                <COND (<NOT <CHECK-BOUNTY ,BOUNTY-WHITE-ORCHARD ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <STOP-EATING-CYCLE>
                <REPEAT ()
                    <TALK-HIGHLIGHT-PERSON ,PRSO "">
                    <CRLF>
                    <TELL "Are you here about the bounty (" T ,BOUNTY-WHITE-ORCHARD ")?" CR>
                    <TELL "1 - I'm here about the bounty." CR> 
                    <TELL "2 - I accept the bounty." CR>
                    <TELL "3 - Goodbye for now." CR>
                    <TELL "Your response: ">
                    <SET KEY <INPUT 1>>
                    <CRLF>
                    <TALK-RESPONSE .KEY !\1 "The beast already claimed lots of victims." ,PRSO>
                    <COND (<EQUAL? .KEY !\2>
                        <ACCEPT-BOUNTY ,BOUNTY-WHITE-ORCHARD ,PRSO>
                        <START-EATING-CYCLE>
                        <RETURN>
                    )(<EQUAL? .KEY !\3>
                        <CRLF>
                        <TALK-HIGHLIGHT-PERSON ,PRSO "Bye!">
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
