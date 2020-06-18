"Data from: The Witcher 3: Wild Hunt Complete Edition Collector's Guide or The World of the Witcher Video Game Compendium."

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
    (LDESC "The griffin resembles a crossbreed of a huge cat and a predatory bird. It mainly inhabits wild, mountainous regions, building its nests on inaccessible peaks. Large, hoofed mammals are its usual prey, but, being highly territorial, a griffin will also passionately defend the area surrounding its nest. Wit the expansion of the human settlements and trade routes, griffins have become more and more of a threat to humans, attacking travelers and merchant caravans, as well as settlers and, particularly shephers and their flocks.||Weak against hybrid oil.")
    (IN GLOBAL-OBJECTS)
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-GERALT
    (SYNONYM GERALT WHITE-WOLF GWYNBLEIDD)
    (DESC "Geralt of Rivia, the White wolf, Gwynbleidd")
    (LDESC "Known to the elves as Gwynbleidd, and to those seeking his services, as the White Wolf, Geralt is a member of the Wolf School. He is no mere swinger of swords, but thoughtful, cunning, resourceful, and an exceptional warrior. Beneath a rather stoic exterior are murmurings of good humor, a readiness to help out those in distress, an offering of goodwill and a mastery of both his blades to help those requesting hs aid.")
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-WITCHERS
    (SYNONYM WITCHER WITCHERS)
    (DESC "Witchers")
    (LDESC "A conviction has arisen amongst both mages and the hoi polloi that Witchers barely rise a har's brath above animals, that they are deformed and bloodthirsty mutants, and that in slaking this thirst they do not limit themselves to the fluids of monsters. Meanwhile the research and observations of Virgial of Ban Ard paints a different picture of this caste.||Of course, it is an indisputable fact that the mutations Witcher undergo influence their temperament, immune system, strenght and endurance, yet one cannot consider them unthinking beings forged only for killing as a result.In fact, Witchers cultivate a unique culture, a specialized body of knowledge, an effective training system, and even a code of honor. They known an incredible amount about the effects of ingesting various organic and inorganic substances, and also a small amount, but nevertheless, something about the fundamentals of magic (simple spells they call \"Signs\").||On the surface the Witchers appear to be a homogeneous social entity, but in truth their fighting styles, training regimens, and world views differ significantly depending on which school they adhere to. The best-known Witcher schools on the Continent are: the Wolf School, the Bear School, the Griffin School, the Viper School, and the Cat School.")
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-SILVER-SWORD
    (SYNONYM SILVER-SWORD SILVER-SWORDS)
    (DESC "Silver sword")
    (LDESC "The silver sword's blade, despite popular belief, is not forged from this metal entirely. Silver is a soft metal, and therefore impossible to properly sharpen. Instead, the core of the blade, as well as its edges, is made from steel coated in silver. The silver sword is chiefly used against creatures born of magic. This group includes all the beasts that are relics of the Conjuction of the Spheres, as well as monsters created through curses, bred or summoned by magic, or otherwise resulting from magical phenomena.")
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-STEEL-SWORD
    (SYNONYM STEEL-SWORD STEEL-SWORDS)
    (DESC "Steel sword")
    (LDESC "It is not true that all witcher steel swords are made from meteorite ore, which is also called siderite and often associated with magical properties. In truth, the weapons can also be made from steel smelted from magnetite ore, as well as siderite and hematite ores.||In time, the witchers' steel swords earned the name of \"swords for men\". A foul moniker, though not one conjured out of thin air.")
    (FLAGS TOPICBIT)>

<OBJECT TOPIC-WOLF-MEDALLION
    (SYNONYM MEDALLION WOLF-MEDALLION)
    (DESC "Wolf Medallion")
    (LDESC "The witcher medallion is not only an insignia of the profession -- it is also one of its tools. It has numerous useful capabilities that are acesible, of course, only to the one who possesses the necessary knowledge and training. First of all, it reacts to the presence of sorcerous auras in the immediate surroundings, making the bearer aware of nearby spell casting, active illusions, or magical creatures. It also warns the owner of sudden dangers, thus providing an additional moment to react.")
    (FLAGS TOPICBIT)>

<ROUTINE WITCHER-F ()
    <COND (<AND <VERB? EXAMINE LOOK-CLOSELY READ> <EQUAL? ,PRSO ,WITCHER ,GERALT>>
		<HMMM>
		<RTRUE>
	)>>

<ROUTINE PRINT-TOPIC (TOPIC)
    <CRLF>
    <HLIGHT ,H-INVERSE>
    <TELL "Topic: " D .TOPIC CR CR>
    <HLIGHT 0>
    <TELL <GETP .TOPIC P?LDESC> CR>>

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
            <HLIGHT ,H-BOLD><TELL "What are you looking for in the codex?">
            <HLIGHT 0><TELL " (Type "><HLIGHT ,H-BOLD><TELL "CLOSE"><HLIGHT 0><TELL " to exit codex)" CR>
            <READLINE>
            <SET W <AND <GETB ,LEXBUF 1> <GET ,LEXBUF 1>>>
        )>
        <COND
            (<EQUAL? .W ,W?NEKKER ,W?NEKKERS ,NEKKER ,TOPIC-NEKKER> <PRINT-TOPIC ,TOPIC-NEKKER>)
            (<EQUAL? .W ,W?ROACH ,W?HORSE ,W?STEED ,W?RIDE, W?MOUNT ,TOPIC-ROACH ,ROACH> <PRINT-TOPIC ,TOPIC-ROACH>)
            (<EQUAL? .W ,W?WITCHER ,W?WITCHERS ,WITCHER> <PRINT-TOPIC ,TOPIC-WITCHERS>)
            (<EQUAL? .W ,W?GERALT ,W?WHITE-WOLF ,W?GWYNBLEIDD ,W?ME, W?MYSELF ,GERALT ,PLAYER> <PRINT-TOPIC ,TOPIC-GERALT>)
            (<EQUAL? .W ,W?GRIFFIN ,W?GRIFFINS ,TOPIC-GRIFFINS ,GRIFFIN> <PRINT-TOPIC ,TOPIC-GRIFFINS>)
            (<EQUAL? .W ,W?SILVER-SWORD ,W?SILVER-SWORDS ,SILVER-SWORD> <PRINT-TOPIC ,TOPIC-SILVER-SWORD>)
            (<EQUAL? .W ,W?STEEL-SWORD ,W?STEEL-SWORDS ,STEEL-SWORD> <PRINT-TOPIC ,TOPIC-STEEL-SWORD>)
            (<EQUAL? .W ,W?MEDALLION ,W?WOLF-MEDALLION ,WOLF-MEDALLION> <PRINT-TOPIC ,TOPIC-WOLF-MEDALLION>)
            (<EQUAL? .W ,W?CLOSE ,W?QUIT> <RETURN>)
            (<TELL CR "The codex is silent about such things." CR>)           
        >
        <COND (<EQUAL? .STOP T> <RTRUE>)>
    >>