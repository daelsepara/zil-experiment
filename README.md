# zil-experiment

Experiments with ZIL (Zork Implementation Language)

## Compiling and running

You need a ZIL compiler or assembler, or something like [ZILF](https://bitbucket.org/jmcgrew/zilf/wiki/Home) installed to convert the .zil file into a format usable by a z-machine interpreter such as [Frotz](https://davidgriffith.gitlab.io/frotz/).

Once installed, you can compile and convert it to a z-machine file using *zilf* and *zapf*

```
./zilf main.zil
./zapf main.zap
```
To play the game, run it with a Z-machine interpreter like *Frotz*

```
frotz main.z3
```

Where you are greeted by the following screen:

```
One night, you dream that you are transported to a video game.

ZIL Experiment
Experiments with ZIL
By SD Separa (2020)
Release 0 / Serial number 200610 / ZILF 0.9 lib J5

Main Hallway
There are exits to the north, south, east, and west.

> 
```

## Further information

This is inspired by [zil-retro](https://github.com/jeffnyman/zil-retro). Head over to that repo for a tutorial on ZIL as well as PDF documents explaining ZIL in more detail. Meanwhile, checkout the [main.zil](main.zil) code for an overview. [DESIGN.md](DESIGN.md) contains some information about the game design.

## The Witcher (ZIL)

Checkout out [The Witcher (ZIL)](/witcher), an ambitious attempt at creating an interactive fiction game set in the Witcher universe of Mr. Andrzej Sapkowski and inspired by the games by CD Projekt Red. It is a work in progress but is playable at this point. Get the latest release [here](https://github.com/daelsepara/zil-experiment/releases/latest) or get the [story file](https://github.com/daelsepara/zil-experiment/releases/latest/download/witcher.z5) playable in Frotz (or other IF interpreters). Feedback most welcome! Enjoy!
