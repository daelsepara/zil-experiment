<SYNTAX READ OBJECT (FIND READBIT) = V-READ PRE-REQUIRES-LIGHT>

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
    (FLAGS TAKEBIT READBIT BOUNTYBIT)>

<ROUTINE ACCEPT-BOUNTY (ARGBOUNTY ARGPERSON "AUX" LOC)
    <COND (<FSET? .ARGBOUNTY ,BOUNTYBIT>
        <SET LOC <GETP .ARGBOUNTY P?BOUNTY-LOC>>
        <COND (<NOT <GETP .ARGBOUNTY P?BOUNTY-ACCEPTED>>
            <TELL "Accept this bounty (" T .ARGBOUNTY ")? ">
            <COND (<YES?>
                <PUTP .ARGBOUNTY P?BOUNTY-ACCEPTED T>
                <CRLF>
                <COND (.LOC
                    <TALK-HIGHLIGHT-PERSON .ARGPERSON "Splendid! You should investigate ">
                    <TELL T .LOC " area for clues.">
                )(ELSE
                    <TALK-HIGHLIGHT-PERSON .ARGPERSON "Splendind! You should look for clues around the area.">
                )>
            )(ELSE
                <CRLF>
                <TALK-HIGHLIGHT-PERSON .ARGPERSON "That is unfortunate. Let me know if you change your mind.">
            )>
            <CRLF>
        )>
    )(ELSE
        <TELL "The what now?" CR>
        <RFALSE>   
    )>>

<SYNTAX D-ACCEPT OBJECT (FIND BOUNTYBIT) (IN-ROOM ON-GROUND HAVE HELD CARRIED) = D-ACCEPTED-BOUNTY>
<SYNTAX D-INVESTIGATE OBJECT (FIND BOUNTYBIT) (IN-ROOM ON-GROUND HAVE HELD CARRIED) = D-INVESTIGATED-BOUNTY>
<SYNTAX D-REPORT OBJECT (FIND BOUNTYBIT) (IN-ROOM ON-GROUND HAVE HELD CARRIED) = D-REPORTED-BOUNTY>
<SYNTAX D-COMPLETE OBJECT (FIND BOUNTYBIT) (IN-ROOM ON-GROUND HAVE HELD CARRIED) = D-COMPLETED-BOUNTY>

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

<CONSTANT BOUNTY-FLAG <TABLE "ACCEPTED" "INVESTIGATED" "REPORTED" "COMPLETED">>

<ROUTINE SET-BOUNTY-STATUS (ARGBOUNTY STATUS)
    <TELL "[DEBUG] SET " D .ARGBOUNTY " FLAG (" <GET BOUNTY-FLAG .STATUS> ") => T" CR>
    <COND (<EQUAL? .STATUS 0> <PUTP .ARGBOUNTY ,P?BOUNTY-ACCEPTED T>)>
    <COND (<EQUAL? .STATUS 1> <PUTP .ARGBOUNTY ,P?BOUNTY-INVESTIGATED T>)>
    <COND (<EQUAL? .STATUS 2> <PUTP .ARGBOUNTY ,P?BOUNTY-REPORTED T>)>
    <COND (<EQUAL? .STATUS 3> <PUTP .ARGBOUNTY ,P?BOUNTY-COMPLETED T>)>>

<ROUTINE ADD-BOUNTY (ARGBOUNTY LOC)
    <COND (<EQUAL? .LOC ,CROSSROADS>
        <COND (<GETP .ARGBOUNTY ,P?BOUNTY-REPORTED>
            <COND (<NOT <GETP .ARGBOUNTY ,P?BOUNTY-COMPLETED>>
                <COND (<NOT <IN? ,GRIFFIN ,CROSSROADS>>
                    <RESET-MONSTER ,GRIFFIN ,HP-GRIFFIN ,CROSSROADS>
                    <REMOVE ,TOPIC-GRIFFINS>
                )>
            )>
        )>
    )>>

<ROUTINE SETUP-BOUNTY (ARGBOUNTY "AUX" LOC ACT INV RPT COMP)
    <COND (.ARGBOUNTY
        <SET LOC <GETP .ARGBOUNTY ,P?BOUNTY-LOC>>
        <SET ACT <GETP .ARGBOUNTY ,P?BOUNTY-ACCEPTED>>
        <SET INV <GETP .ARGBOUNTY ,P?BOUNTY-INVESTIGATED>>
        <SET RPT <GETP .ARGBOUNTY ,P?BOUNTY-REPORTED>>
        <SET COMP <GETP .ARGBOUNTY ,P?BOUNTY-COMPLETED>>
        
        <COND (<EQUAL? ,HERE .LOC>
            <COND (<NOT .ACT>
                <TELL "[Bounty not accepted]">
            )(.COMP
                <TELL "[Bounty completed]">
            )
            (.RPT
                <TELL "[Bounty Reported. Will setup monsters.]">
                <ADD-BOUNTY .ARGBOUNTY ,HERE>
            )(.INV
                <TELL "[Area investigated.]">
            )(.ACT
                <TELL "[Investigation ongoing. Setup clues-]">
            )>
            <CRLF><CRLF>
        )>
    )>>