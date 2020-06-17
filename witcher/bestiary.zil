<OBJECT CODEX
    (DESC "Wicher Codex")
    (SYNONYM CODEX TOME)
    (ADJECTIVE WITCHER)
    (IN GLOBAL-OBJECTS)
    (FLAGS READBIT)
    (ACTION READ-CODEX-F)>

<OBJECT TOPIC-NEKKER
    (DESC "Nekker")
    (LDESC "A lone nekker is harmless. Five are dangerous. Ten can kill even a veteran monster slayer. Particularly troublesome are the larger, stronger individuals known as warriors, as well as the rare breed of nekkers known as phoocas.")>

<ROUTINE READ-CODEX-F ("AUX" W)
    <REPEAT ()
        <CRLF>
        <TELL "What are you looking for in the codex?" CR>
        <READLINE>
        <SET W <AND <GETB ,LEXBUF 1> <GET ,LEXBUF 1>>>
        <COND (<EQUAL? .W ,W?NEKKER ,W?NEKKERS>
            <CRLF>
            <HLIGHT ,H-BOLD>
            <TELL "Topic: Nekkers" CR CR>
            <HLIGHT 0>
            <TELL <GETP TOPIC-NEKKER P?LDESC> CR>
        )>
        <COND (<EQUAL? .W ,W?CLOSE>
            <RETURN>
        )>
    >>