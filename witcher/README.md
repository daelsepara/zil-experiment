# Witcher ZIL

## Design Goals

With our increasing understanding of ZIL, it is time to create a more sophisticated game. Here, we try to create an interactive fiction game set in the Witcher game universe by CD Projekt Red.

Our goals are to implement these features

- [X] combat! (14 June 2020)
- [X] silver and steel swords that can be enhanced by the application of certain oils (11 June 2020)
- [X] swords with oil should also confer bonuses when combatting specific monsters (14 June 2020)
- [X] witcher medallion that can detect invisible objects (12 June 2020)
- [X] travelling with or without Roach (12 June 2020)
- [X] eating/drinking food and/or potions and decoctions (13 June 2020, eating, 22 June 2020 cat's eye potion)
- [X] monster bounties (19 June 2020)
- [X] mechanisms for generic NPCs (blacksmith, alchemist, merchant) (20 June 2020)

### Phase 2 goals (Starting 22 June 2020)

- [X] random money drops/pickups (23 June 2020)
- [ ] armorer NPC
- [X] non-monster-killing quests (22 June 2020 search quest)
- [ ] superior versions of oils
- [ ] non-bounty related NPC dialogs
- [ ] other interesting objects

### Phase 3 (TBD)

- [ ] other types of silver/steel swords
- [ ] overall story or plot arc

## Compiling and running

You need a ZIL compiler or assembler, or something like [ZILF](https://bitbucket.org/jmcgrew/zilf/wiki/Home) installed to convert the .zil file into a format usable by a z-machine interpreter such as [Frotz](https://davidgriffith.gitlab.io/frotz/).

Once installed, you can compile and convert it to a z-machine file using *zilf* and *zapf*

```
./zilf witcher.zil
./zapf witcher.zap
```

To play the game, run it with a Z-machine interpreter like *Frotz*

```
frotz witcher.z5
```

Where you are greeted by the following screen:

```
ZIL Witcher
Experiments with ZIL
By SD Separa (2020)

Inspired by the Witcher Games by CD Projekt Red

Release 0 / Serial number 200612 / ZILF 0.9 lib J5

------------------------------------------------------
Once you were many. Now you are few. Hunters. Killers of the world's filth. Witchers. The ultimate killing machines. Among you, a legend, the one they call Geralt of
Rivia, the White Wolf.

That legend is you.

------------------------------------------------------

Campsite
A small campfire is burning underneath a tree. All is quiet except for the crackling sounds of burning wood. The fire keeps the wolves and other would-be predators at
bay.

Roach is here.

>
```

(work in progress)
