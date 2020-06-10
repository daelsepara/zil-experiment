# zil-experiment
Experiments with ZIL (Zork Implementation Language)

## Compiling and running

You need a ZIL compiler or assembler, or something like [ZILF](https://bitbucket.org/jmcgrew/zilf/wiki/Home) installed to convert the .zil file into a format usable by a z-machine interpreter such as [Frotz](https://davidgriffith.gitlab.io/frotz/).

Once installed, you can compile and convert it to a z-machine file using *zilf* and *zapf*:

```
./zilf main.zil
./zapf main.zap
```
To play the game, run it with a Z-machine interpreter like Frotz:

```
frotz main.z3
```
