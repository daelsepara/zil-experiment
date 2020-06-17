"Data from: https://thewitcher3.wiki.fextralife.com"

<OBJECT CODEX
    (DESC "Wicher Codex")
    (SYNONYM CODEX TOME)
    (ADJECTIVE WITCHER)
    (IN GLOBAL-OBJECTS)
    (FLAGS READBIT)
    (ACTION READ-CODEX-F)>

<OBJECT TOPIC-NEKKER
    (DESC "Nekkers")
    (LDESC "A lone nekker is harmless. Five are dangerous. Ten can kill even a veteran monster slayer. Particularly troublesome are the larger, stronger individuals known as warriors, as well as the rare breed of nekkers known as phoocas.")>

<OBJECT TOPIC-ROACH
    (DESC "Roach")
    (LDESC "Roach is the name that Geralt of Rivia has given to every horse that he keeps as a companion It is not known why he calls them by this name, as seemingly he followed this tradition before meeting Vernon Roche meaning the two names are likely unrelated (as Roche should in fact be pronounced \"Rosh\" (not \"Roach\") like in polish, the original version). For an unknown reason Geralt prefers to ride female horses, perhaps it is a simple matter of preference or it is related to an unspoken part of his past. Within The Witcher 3, Geralt may ride horses and it is likely that whether he has many or just one, the horse will be called Roach. There have been at least three different horses named Roach that Geralt has kept.")>

<ROUTINE PRINT-TOPIC (TOPIC)
    <CRLF>
    <HLIGHT ,H-BOLD>
    <TELL "Topic: " D .TOPIC CR CR>
    <HLIGHT 0>
    <TELL <GETP .TOPIC P?LDESC> CR>>

<ROUTINE READ-CODEX-F ("AUX" W)
    <REPEAT ()
        <CRLF>
        <TELL "What are you looking for in the codex?" CR>
        <READLINE>
        <SET W <AND <GETB ,LEXBUF 1> <GET ,LEXBUF 1>>>
        <COND
            (<EQUAL? .W ,W?NEKKER ,W?NEKKERS> <PRINT-TOPIC ,TOPIC-NEKKER>)
            (<EQUAL? .W ,W?ROACH> <PRINT-TOPIC ,TOPIC-ROACH>)
            (<EQUAL? .W ,W?CLOSE ,W?QUIT> <RETURN>)
        >
    >>