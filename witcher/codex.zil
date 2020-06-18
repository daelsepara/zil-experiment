"Data from: https://witcher.fandom.com/wiki/Witcher_Wiki"

<OBJECT WITCHER
    (DESC "Geralt of Rivia")
    (SYNONYM WITCHER GERALT WITCHERS)
    (IN GLOBAL-OBJECTS)
    (ACTION WITCHER-F)
    (FLAGS NARTICLEBIT READBIT PERSONBIT)>

<ROUTINE WITCHER-F ()
    <COND (<AND <VERB? READ EXAMINE LOOK-CLOSELY> <EQUAL? ,PRSO ,WITCHER>>
		<PRINT-TOPIC ,TOPIC-WITCHERS>
		<RTRUE>
	)>>

<OBJECT CODEX
    (DESC "Wicher Codex")
    (SYNONYM CODEX TOME)
    (IN GLOBAL-OBJECTS)
    (FLAGS READBIT CODEXBIT)
    (ACTION READ-CODEX-F)>

<OBJECT TOPIC-NEKKER
    (DESC "Nekkers")
    (LDESC "Nekkers are small, misshapen creatures that inhabit remote areas. They make their abodes in dark woods, damp gullies, and shadowy dales, where they live in colonies composed of anywhere from a dozen to several dozen individuals. Their lars take the form of dug-out hollows, interconnected by narrow underground tunnels. Nekkers use these pathways to quickly travel around their colony and its immediate surroundings, disappearing into the arth and then seeming to instantaneously pop up elsewhere.||Weak against ogroid oil.")
    (SYNONYM NEKKERS NEKKER)
    (IN GLOBAL-OBJECTS)
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-ROACH
    (DESC "Roach")
    (LDESC "Geralt named his every mount Roach, though no one really knows why or what Geralt had in mind with this name. When asked, Geralt would dodge the question or give an evasive answer. Perhaps this had just been the first word that came to his head? Roach, for her part, seemed to accept the name with no reservations.")>

<OBJECT TOPIC-WITCHERS
    (SYNONYM WITCHER WITCHERS)
    (DESC "Witchers")
    (LDESC "\"Indeed, there is nothing more repulsive than these monsters that defy nature and are known by the name of witcher, as they are the offspring of foul sorcery and witchcraft. They are unscrupulous scoundrels without conscience and virtue, veritable creatures from hell capable only of taking lives...\"")>

<ROUTINE PRINT-TOPIC (TOPIC)
    <CRLF>
    <HLIGHT ,H-INVERSE>
    <TELL "Topic: " D .TOPIC CR CR>
    <HLIGHT 0>
    <TELL <GETP .TOPIC P?LDESC> CR>>

<SYNTAX LOOK AT OBJECT (FIND TOPICBIT) = V-LOOK-TOPIC>
<SYNTAX EXAMINE OBJECT (FIND TOPICBIT) = V-EXAMINE-TOPIC>

<ROUTINE V-LOOK-TOPIC ()
    <COND (<NOT <FSET? ,PRSO TOPICBIT>>
        <PERFORM ,V?EXAMINE ,PRSO>
        <RTRUE>
    )>
    <TELL "You don't see that here." CR>>

<ROUTINE V-EXAMINE-TOPIC ()
    <COND (<NOT <FSET? ,PRSO TOPICBIT>>
        <PERFORM ,V?LOOK-CLOSELY ,PRSO>
        <RTRUE>
    )>
    <TELL "You don't see that here." CR>>

<SYNTAX READ OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ABOUT OBJECT (FIND TOPICBIT) (IN-ROOM ON-GROUND) = V-READ PRE-REQUIRES-LIGHT>

<ROUTINE READ-CODEX-F ("AUX" W (STOP <>))
    <COND (<NOT <EQUAL? ,PRSO ,CODEX>>
        <RFALSE>
    )>
    <REPEAT ()
        <COND (,PRSI
            <SET W ,PRSI>
            <SET .STOP T>
        )(ELSE
            <CRLF>
            <HLIGHT ,H-BOLD>
            <TELL "What are you looking for in the codex?" CR>
            <HLIGHT 0>
            <READLINE>
            <SET W <AND <GETB ,LEXBUF 1> <GET ,LEXBUF 1>>>
        )>
        <COND
            (<EQUAL? .W ,W?NEKKER ,W?NEKKERS ,NEKKER ,TOPIC-NEKKER> <PRINT-TOPIC ,TOPIC-NEKKER>)
            (<EQUAL? .W ,W?ROACH ,W?HORSE ,W?STEED ,W?RIDE, W?MOUNT ,ROACH> <PRINT-TOPIC ,TOPIC-ROACH>)
            (<EQUAL? .W ,W?WITCHER ,W?WITCHERS ,W?ME ,W?MYSELF ,W?GERALT ,WITCHER ,PLAYER> <PRINT-TOPIC ,TOPIC-WITCHERS>)
            (<EQUAL? .W ,W?CLOSE ,W?QUIT> <RETURN>)
            (<TELL CR "The codex is silent about such things." CR>)           
        >
        <COND (<EQUAL? .STOP T> <RTRUE>)>
    >>