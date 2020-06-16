<OBJECT BOUNTY-WHITE-ORCHARD
    (IN PLAYER)
    (DESC "Bounty: Beast of White Orchard")
    (ADJECTIVE BEAST WHITE ORCHARD WHITE-ORCHARD)
    (SYNONYM BOUNTY)
    (TEXT "A vicious beast is terrorizing the White Orchard area. Travelling in and out of town is forbidden. Merchants should comply. Look for the alderman at the inn for further information")
    (SIZE 0)
    (BOUNTY-REWARD 1500)
    (BOUNTY-ACCEPTED <>)
    (BOUNTY-INVESTIGATED <>)
    (BOUNTY-COMPLETED <>)
    (BOUNTY-LOC <>)
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

<ROUTINE ACCEPT-BOUNTY (ARGBOUNTY "AUX" LOC)
    <COND (<AND .ARGBOUNTY <FSET? .ARGBOUNTY ,BOUNTYBIT>>
        <SET LOC <GETP .ARGBOUNTY P?BOUNTY-LOC>>
        <COND (<GETP .ARGBOUNTY P?BOUNTY-ACCEPTED>
            <COND (<GETP .ARGBOUNTY P?BOUNTY-COMPLETED>
                <TELL CR "\"You have already completed the bounty (" T .ARGBOUNTY ")!\"" CR>
            )(ELSE
                <TELL CR "\"How goes the hunt (" T .ARGBOUNTY ")? ">
                <TELL "Please come back after completing the bounty for your reward!\"" CR>
            )>
        )(ELSE
            <TELL "Accept this bounty (" T .ARGBOUNTY ")? ">
            <COND (<YES?>
                <PUTP .ARGBOUNTY P?BOUNTY-ACCEPTED T>
                <COND (.LOC
                    <TELL CR "\"Splendind!. You should investigate " T .LOC " area for clues.\"" CR>
                )(ELSE
                    <TELL CR "\"Splendind!. You should look for clues around the area.\"" CR>
                )>
            )(ELSE
                <TELL CR "\"That is unfortunate. Let me know if you change your mind.\"" CR>
            )>
        )>
    )(ELSE
        <TELL "The what now?" CR>
        <RFALSE>   
    )>>