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
    (FLAGS TAKEBIT RLANDBIT READBIT NARTICLEBIT)>

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
    (FLAGS TAKEBIT RLANDBIT READBIT NARTICLEBIT)>

<ROUTINE ACCEPT-BOUNTY (ARGBOUNTY ARGAREA)
    <COND (.ARGBOUNTY
        <TELL "Accept this bounty (" T .ARGBOUNTY ")? ">
        <COND (<YES?>
            <PUTP .ARGBOUNTY P?BOUNTY-ACCEPTED T>
            <TELL "Splendind!. You should investigate " T .ARGAREA " area for clues" CR>
        )(ELSE
            <TELL "That is unfortunate. Let me know if you change your mined." CR>
        )>
    )>>