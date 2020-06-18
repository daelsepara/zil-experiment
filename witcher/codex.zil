"Data from: https://witcher.fandom.com/wiki/Witcher_Wiki"

<OBJECT WITCHER
    (DESC "Geralt of Rivia")
    (SYNONYM WITCHER GERALT WITCHERS)
    (IN GLOBAL-OBJECTS)
    (ACTION WITCHER-F)
    (FLAGS NARTICLEBIT PERSONBIT)>

<ROUTINE WITCHER-F ()
    <COND (<AND <VERB? EXAMINE LOOK-CLOSELY READ> <EQUAL? ,PRSO ,WITCHER>>
		<HMMM>
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
    (SYNONYM ROACH)
    (LDESC "Geralt named his every mount Roach, though no one really knows why or what Geralt had in mind with this name. When asked, Geralt would dodge the question or give an evasive answer. Perhaps this had just been the first word that came to his head? Roach, for her part, seemed to accept the name with no reservations.")
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-GRIFFINS
    (SYNONYM GRIFFIN GRIFFINS)
    (DESC "Griffins")
    (LDESC "The griffin resembles a crossbreed of a huge cat and a predatory bird. It mainly inhabits wild, mountainous regions, building its nests on inaccessible peaks. Large, hoofed mammals are its usual prey, but, being highly territorial, a griffin will also passionately defend the area surrounding its nest. Wit the expansion of the human settlements and trade routes, griffins have become more and more of a threat to humans, attacking travelers and merchant caravans, as well as settlers and, particularly shephers and their flocks.")
    (IN GLOBAL-OBJECTS)
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-WITCHERS
    (SYNONYM WITCHER WITCHERS)
    (DESC "Witchers")
    (LDESC "\"Indeed, there is nothing more repulsive than these monsters that defy nature and are known by the name of witcher, as they are the offspring of foul sorcery and witchcraft. They are unscrupulous scoundrels without conscience and virtue, veritable creatures from hell capable only of taking lives...\"")
    (FLAGS TOPICBIT)>

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

<SYNTAX READ OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ABOUT OBJECT (FIND READBIT) (IN-ROOM ON-GROUND) = READ-CODEX-F>
<SYNTAX READ OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ON OBJECT (FIND READBIT) (IN-ROOM ON-GROUND) = READ-CODEX-F>
<SYNTAX CONSULT OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ABOUT OBJECT (FIND TOPICBIT) (IN-ROOM ON-GROUND) = READ-CODEX-F>
<SYNTAX CONSULT OBJECT (FIND CODEXBIT) (IN-ROOM ON-GROUND) ON OBJECT (FIND TOPICBIT) (IN-ROOM ON-GROUND) = READ-CODEX-F>

<ROUTINE READ-CODEX-F ("AUX" W (STOP <>))
    <COND (<NOT <FSET? ,PRSO ,CODEXBIT>>
        <TELL "You cannot read " T ,PRSO>
        <COND (,PRSI
            <TELL " about " T ,PRSI>
        )>
        <CRLF>
        <RTRUE>
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
            (<EQUAL? .W ,W?ROACH ,W?HORSE ,W?STEED ,W?RIDE, W?MOUNT ,TOPIC-ROACH ,ROACH> <PRINT-TOPIC ,TOPIC-ROACH>)
            (<EQUAL? .W ,W?WITCHER ,W?WITCHERS ,W?ME ,W?MYSELF ,W?GERALT ,WITCHER ,PLAYER> <PRINT-TOPIC ,TOPIC-WITCHERS>)
            (<EQUAL? .W ,W?GRIFFIN ,W?GRIFFINS ,TOPIC-GRIFFINS> <PRINT-TOPIC ,TOPIC-GRIFFINS>)
            (<EQUAL? .W ,W?CLOSE ,W?QUIT> <RETURN>)
            (<TELL CR "The codex is silent about such things." CR>)           
        >
        <COND (<EQUAL? .STOP T> <RTRUE>)>
    >>