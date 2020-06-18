<SYNTAX ASK OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNTAX TALK TO OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) ABOUT OBJECT (ON-GROUND IN-ROOM) (FIND BOUNTYBIT) = V-TALK>
<SYNTAX SPEAK WITH OBJECT (IN-ROOM) (FIND PERSONBIT) = V-TALK>
<SYNONYM SPEAK CHAT>

<CONSTANT ROACH-RESPONSES <LTABLE 2 "clueless" "amused" "fascinated" "bored" "interested" "enthusiastic">>

<ROUTINE V-TALK ()
    <COND(<FSET? ,PRSO ,PERSONBIT>
        <COND (<EQUAL? ,PRSO ,WITCHER ,PLAYER>
            <TELL "Hmmmm..." CR>
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

<ROUTINE GENERIC-BOUNTY-DIALOG (ARGPERSON ARGBOUNTY)
    <COND (<NOT <GETP .ARGBOUNTY P?BOUNTY-INVESTIGATED>>
        <TALK-HIGHLIGHT-PERSON .ARGPERSON "You should probably continue investigating ">
        <TELL T <GETP .ARGBOUNTY P?BOUNTY-LOC> " area." CR>
    )(ELSE
        <COND (<NOT <GETP .ARGBOUNTY P?BOUNTY-REPORTED>>
            <TALK-HIGHLIGHT-PERSON .ARGPERSON "You have enough clues about the monster you are dealing with! Now is the time to deal with it!">
            <PUTP .ARGBOUNTY ,P?BOUNTY-REPORTED T>
        )(ELSE
            <COND (<NOT <GETP .ARGBOUNTY ,P?BOUNTY-COMPLETED>>
                <TALK-HIGHLIGHT-PERSON .ARGPERSON "Please come back after you have dealt with the beast for your reward.">
            )(ELSE
                <TALK-HIGHLIGHT-PERSON .ARGPERSON "Thanks, witcher! Our town is safe again!">
                <COND (<G? <GETP .ARGBOUNTY ,P?BOUNTY-REWARD> 0>
                    <SETG ,WITCHER-ORENS <+ ,WITCHER-ORENS <GETP .ARGBOUNTY ,P?BOUNTY-REWARD>>>
                    <TELL " Here is your reward. (" N <GETP .ARGBOUNTY ,P?BOUNTY-REWARD> " Orens)">
                    <PUTP .ARGBOUNTY ,P?BOUNTY-REWARD 0>
                )>
            )>
        )>
        <CRLF>
    )>>

<ROUTINE GENERIC-BOUNTY-TALK (ARGBOUNTY ARGPERSON ARGTEXT "AUX" KEY)
    <COND (,RIDING-VEHICLE
        <TELL "You should dismount from " T ,CURRENT-VEHICLE " first!" CR>
        <RTRUE>
    )>
    <COND (<VERB? TALK>
        <CRLF>
        <COND (<NOT <EQUAL? ,PRSO .ARGPERSON>>
            <TALK-HIGHLIGHT-PERSON .ARGPERSON "You talking to me?">
            <CRLF>
            <RTRUE>
        )>
        <COND (<IN? .ARGBOUNTY ,PLAYER>
            <COND (<GETP .ARGBOUNTY P?BOUNTY-ACCEPTED>
                <COND (<NOT <CHECK-BOUNTY .ARGBOUNTY ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <GENERIC-BOUNTY-DIALOG .ARGPERSON .ARGBOUNTY>
            )(ELSE
                <COND (<NOT <CHECK-BOUNTY .ARGBOUNTY ,PRSI ,PRSO>>
                    <RETURN>
                )>
                <STOP-EATING-CYCLE>
                <REPEAT ()
                    <TALK-HIGHLIGHT-PERSON .ARGPERSON "">
                    <CRLF>
                    <TELL "Are you here about the bounty (" T .ARGBOUNTY ")?" CR>
                    <TELL "1 - I'm here about the bounty." CR> 
                    <TELL "2 - I accept the bounty." CR>
                    <TELL "3 - Goodbye for now." CR>
                    <TELL "Your response: ">
                    <SET KEY <INPUT 1>>
                    <CRLF>
                    <TALK-RESPONSE .KEY !\1 .ARGTEXT ,PRSO>
                    <COND (<EQUAL? .KEY !\2>
                        <ACCEPT-BOUNTY .ARGBOUNTY ,PRSO>
                        <START-EATING-CYCLE>
                        <RETURN>
                    )(<EQUAL? .KEY !\3>
                        <CRLF>
                        <TALK-HIGHLIGHT-PERSON .ARGPERSON "Bye!">
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
