# Batch SRB2 launcher
Game launcher for Sonic Robo Blast 2 v2.2 made in Batch

## Configuration
In order to launch SRB2 from this launcher you have to specify your gamefolder first. By default it's set to `C:\GAMES\SRB2` but you can change this.
Files with ***.BAT** extension (batch files) are regular text files which means you can freely open and edit them in any text editor around.
Right at the beginning there are 2 configuration variables that you can change, it should look like this:
```batch
SET GAMEDIR=C:\GAMES\SRB2\
SET SRB2_EXEC=SRB2win.exe
```

- `GAMEDIR` - the game folder where SRB2 executable and SRB2.PK3 are located
- `SRB2_EXEC` - the name of the default executable to use
