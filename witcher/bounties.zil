<SYNTAX READ ABOUT OBJECT (FIND READBIT) (HAVE HELD CARRIED ON-GROUND IN-ROOM) = V-READ PRE-REQUIRES-LIGHT>

<OBJECT BOUNTY-WHITE-ORCHARD
    (IN PLAYER)
    (DESC "Bounty: Beast of White Orchard")
    (ADJECTIVE BEAST WHITE ORCHARD WHITE-ORCHARD)
    (SYNONYM BOUNTY)
    (TEXT "A vicious beast is terrorizing the White Orchard area. Travelling in and out of town is forbidden. Merchants should comply. Look for the alderman at White Orchard for further information.")
    (SIZE 0)
    (BOUNTY-REWARD 1500)
    (BOUNTY-ACCEPTED <>)
    (BOUNTY-INVESTIGATED <>)
    (BOUNTY-COMPLETED <>)
    (BOUNTY-LOC CROSSROADS)
    (FLAGS TAKEBIT RLANDBIT READBIT NARTICLEBIT BOUNTYBIT)>

<OBJECT BOUNTY-BANDITS
    (IN PLAYER)
    (DESC "Bounty: Raid Bandit Camp")
    (ADJECTIVE BANDIT BANDITS)
    (SYNONYM BOUNTY)
    (TEXT "Groups of bandits are robbing, pillaging and looting around White Orchard. Townsfolk are advised to travel in large groups for their own safety. Talk to the magistrate.")
    (SIZE 0)
    (BOUNTY-REWARD 500)
    (BOUNTY-ACCEPTED <>)
    (BOUNTY-INVESTIGATED <>)
    (BOUNTY-COMPLETED <>)
    (BOUNTY-LOC <>)
    (FLAGS TAKEBIT RLANDBIT READBIT NARTICLEBIT BOUNTYBIT)>

<ROUTINE ACCEPT-BOUNTY (ARGBOUNTY ARGPERSON "AUX" LOC)
    <COND (<FSET? .ARGBOUNTY ,BOUNTYBIT>
        <SET LOC <GETP .ARGBOUNTY P?BOUNTY-LOC>>
        <COND (<NOT <GETP .ARGBOUNTY P?BOUNTY-ACCEPTED>>
            <TELL "Accept this bounty (" T .ARGBOUNTY ")? ">
            <COND (<YES?>
                <PUTP .ARGBOUNTY P?BOUNTY-ACCEPTED T>
                <CRLF>
                <COND (.LOC
                    <TALK-HIGHLIGHT-PERSON .ARGPERSON "Splendid!. You should investigate ">
                    <TELL T .LOC " area for clues.">
                )(ELSE
                    <TALK-HIGHLIGHT-PERSON .ARGPERSON "Splendind!. You should look for clues around the area.">
                )>
                <CRLF>
            )(ELSE
                <CRLF>
                <TALK-HIGHLIGHT-PERSON .ARGPERSON "That is unfortunate. Let me know if you change your mind.">
                <CRLF>
            )>
        )>
    )(ELSE
        <TELL "The what now?" CR>
        <RFALSE>   
    )>>