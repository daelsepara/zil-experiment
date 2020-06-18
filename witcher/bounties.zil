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
    (BOUNTY-REPORTED <>)
    (BOUNTY-COMPLETED <>)
    (BOUNTY-LOC CROSSROADS)
    (BOUNTY-MONSTER GRIFFIN)
    (VALUE 500)
    (FLAGS TAKEBIT READBIT BOUNTYBIT)>

<OBJECT BOUNTY-BANDITS
    (IN PLAYER)
    (DESC "Bounty: Raid Bandit Camp")
    (ADJECTIVE BANDIT BANDITS)
    (SYNONYM BOUNTY)
    (TEXT "Groups of bandits are robbing, pillaging and looting around White Orchard. Townsfolk are advised to travel in large groups for their own safety. Talk to the magistrate at the Nilfgaardian outpost.")
    (SIZE 0)
    (BOUNTY-REWARD 500)
    (BOUNTY-ACCEPTED <>)
    (BOUNTY-INVESTIGATED <>)
    (BOUNTY-REPORTED <>)
    (BOUNTY-COMPLETED <>)
    (BOUNTY-MONSTER BANDITS)
    (BOUNTY-LOC <>)
    (VALUE 100)
    (FLAGS TAKEBIT READBIT BOUNTYBIT)>

<ROUTINE ACCEPT-BOUNTY (BOUNTY PERSON "AUX" LOC)
    <COND (<FSET? .BOUNTY ,BOUNTYBIT>
        <SET LOC <GETP .BOUNTY P?BOUNTY-LOC>>
        <COND (<NOT <GETP .BOUNTY P?BOUNTY-ACCEPTED>>
            <TELL "Accept this bounty (" T .BOUNTY ")? ">
            <COND (<YES?>
                <PUTP .BOUNTY P?BOUNTY-ACCEPTED T>
                <CRLF>
                <COND (.LOC
                    <TALK-HIGHLIGHT-PERSON .PERSON "Splendid! You should investigate ">
                    <TELL T .LOC " area for clues.">
                )(ELSE
                    <TALK-HIGHLIGHT-PERSON .PERSON "Splendind! You should look for clues around the area.">
                )>
            )(ELSE
                <CRLF>
                <TALK-HIGHLIGHT-PERSON .PERSON "That is unfortunate. Let me know if you change your mind.">
            )>
            <CRLF>
        )>
    )(ELSE
        <TELL "The what now?" CR>
        <RFALSE>   
    )>>

"
0 - Accepted
1 - Investigated
2 - Reported
3 - Completed
"
<ROUTINE D-ACCEPTED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 0>>

<ROUTINE D-INVESTIGATED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 1>>

<ROUTINE D-REPORTED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 2>>

<ROUTINE D-COMPLETED-BOUNTY ()
    <SET-BOUNTY-STATUS ,PRSO 3>>

<ROUTINE SET-BOUNTY-STATUS (BOUNTY STATUS)
    <TELL "[DEBUG] SET " D .BOUNTY " FLAG (" <GET BOUNTY-FLAG .STATUS> ") => T" CR>
    <COND (<EQUAL? .STATUS 0> <PUTP .BOUNTY ,P?BOUNTY-ACCEPTED T>)>
    <COND (<EQUAL? .STATUS 1> <PUTP .BOUNTY ,P?BOUNTY-INVESTIGATED T>)>
    <COND (<EQUAL? .STATUS 2> <PUTP .BOUNTY ,P?BOUNTY-REPORTED T>)>
    <COND (<EQUAL? .STATUS 3> <PUTP .BOUNTY ,P?BOUNTY-COMPLETED T>)>>

<ROUTINE ADD-BOUNTY (BOUNTY LOC)
    <COND (<EQUAL? .LOC ,CROSSROADS>
        <COND (<GETP .BOUNTY ,P?BOUNTY-REPORTED>
            <COND (<NOT <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
                <COND (<NOT <IN? ,GRIFFIN ,CROSSROADS>>
                    <RESET-MONSTER ,GRIFFIN ,HP-GRIFFIN ,CROSSROADS>
                    <REMOVE ,TOPIC-GRIFFINS>
                )>
            )>
        )>
    )>>

<ROUTINE SETUP-BOUNTY (BOUNTY "AUX" LOC ACT INV RPT COMP)
    <COND (.BOUNTY
        <SET LOC <GETP .BOUNTY ,P?BOUNTY-LOC>>
        <SET ACT <GETP .BOUNTY ,P?BOUNTY-ACCEPTED>>
        <SET INV <GETP .BOUNTY ,P?BOUNTY-INVESTIGATED>>
        <SET RPT <GETP .BOUNTY ,P?BOUNTY-REPORTED>>
        <SET COMP <GETP .BOUNTY ,P?BOUNTY-COMPLETED>>
        
        <COND (<EQUAL? ,HERE .LOC>
            <COND (<NOT .ACT>
                <TELL "[Bounty not accepted]">
            )(.COMP
                <TELL "[Bounty completed]">
            )
            (.RPT
                <TELL "[Bounty Reported. Will setup monsters.]">
                <ADD-BOUNTY .BOUNTY ,HERE>
            )(.INV
                <TELL "[Area investigated.]">
            )(.ACT
                <TELL "[Investigation ongoing. Setup clues-]">
            )>
            <CRLF><CRLF>
        )>
    )>>