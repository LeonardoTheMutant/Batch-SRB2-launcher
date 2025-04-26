@ECHO OFF

SET DRIVE=C:
SET GAMEDIR=%DRIVE%\SRB2
SET SRB2_EXEC=srb2win.exe

%DRIVE%
CD %GAMEDIR%
IF NOT EXIST %GAMEDIR% GOTO GAMEDIRFAIL
IF NOT EXIST %GAMEDIR%\%SRB2_EXEC% GOTO EXENOTFOUND
IF NOT EXIST %GAMEDIR%\SRB2.PK3 GOTO PK3NOTFOUND
:MENU
CLS
ECHO ====================================
ECHO = Sonic Robo Blast 2 v2.2 launcher =
ECHO ====================================
ECHO.
ECHO Game folder:     %GAMEDIR%
ECHO SRB2 executable: %SRB2_EXEC%
ECHO.
ECHO 1 - Launch normally
ECHO 2 - Launch with ADD-ONs
ECHO 3 - Launch ADD-ON from test folder
ECHO 4 - Multiplayer...
ECHO 5 - Custom command line launch
ECHO 6 - Edit CONFIG.CFG
ECHO 7 - Edit AUTOEXEC.CFG
ECHO 8 - Switch executable
ECHO 9 - Quit
ECHO.
REM SET /P MENU=Select number:
CHOICE /C 123456789 /N /M "Select menu number "
IF %ERRORLEVEL%==1 GOTO NORMAL
IF %ERRORLEVEL%==2 GOTO ADDONS
IF %ERRORLEVEL%==3 GOTO FOLDER
IF %ERRORLEVEL%==4 GOTO MULTIP
IF %ERRORLEVEL%==5 GOTO CUSTOM
IF %ERRORLEVEL%==6 GOTO CONFIGedit
IF %ERRORLEVEL%==7 GOTO AUTOEXECedit
IF %ERRORLEVEL%==8 GOTO SWITCHEXE
IF %ERRORLEVEL%==9 GOTO EXIT

:NORMAL
ECHO.
ECHO Launching %SRB2_EXEC% ...
START %GAMEDIR%\%SRB2_EXEC%
GOTO MENU

:ADDONS
CLS
ECHO =====================
ECHO = ADD-ONs selection =
ECHO =====================
ECHO.
IF NOT EXIST %GAMEDIR%\ADDONS GOTO ADDONSDIRFAIL
ECHO Contents of addons\ directory:
ECHO ==============================
DIR /W ADDONS\
ECHO ================================
ECHO.
IF NOT EXIST %GAMEDIR%\DOWNLOAD GOTO DOWNLOADDIRFAIL
ECHO Contents of DOWNLOAD\ directory:
ECHO ================================
DIR /W DOWNLOAD\
ECHO ================================
GOTO ADDON_PROMPT

:ADDONSDIRFAIL
ECHO Cannot find the ADDONS folder to list it, is your GAMEDIR correct?
GOTO ADDON_PROMPT

:DOWNLOADDIRFAIL
ECHO Cannot find the DOWNLOAD folder to list it, is your GAMEDIR correct?

:ADDON_PROMPT
ECHO.
ECHO Enter the full path of ADD-ONs to add, current directory is: %GAMEDIR%
ECHO Multiple files are also allowed
ECHO Example: ADDONS\mod1.WAD ADDONS\cool_mod.pk3 DOWNLOAD\mod2.WAD
SET /P ADDONline=:
ECHO Launching %SRB2_EXEC% -FILE %ADDONline%
START %GAMEDIR%\%SRB2_EXEC% -FILE %ADDONline%
GOTO MENU

:FOLDER
CLS
ECHO ======================
ECHO = Test ADD-ON folder =
ECHO ======================
ECHO.
ECHO Enter the full path to ADD-ON folder you want to test
ECHO Current directry is %GAMEDIR%
SET /P ADDONfolder=:
START %GAMEDIR%\%SRB2_EXEC% -FOLDER %ADDONfolder%
GOTO MENU

:MULTIP
CLS
ECHO ===============
ECHO = Multiplayer =
ECHO ===============
ECHO.
ECHO 1 - Connect to GLobal/LAN server
ECHO 2 - Start server
ECHO 3 - Back
ECHO.
CHOICE /C 123 /N /M "Select number "
IF %ERRORLEVEL%==1 GOTO CONNECT
IF %ERRORLEVEL%==2 GOTO SERVER
IF %ERRORLEVEL%==3 GOTO MENU

:CONNECT
CLS
ECHO  Connect
ECHO =========
ECHO.
ECHO Type the IP adress of server to connect
ECHO Additional arguments must be AFTER IP
ECHO.
SET /P CONNECTip=:
ECHO Launching %SRB2_EXEC% -CONNECT %CONNECTip% ...
START %GAMEDIR%\%SRB2_EXEC% -CONNECT %CONNECTip%
GOTO MENU

:SERVER
CLS
ECHO  Start Server
ECHO ==============
ECHO.
ECHO Type your arguments to start server
ECHO Current prompt arguments have -SERVER already
ECHO.
ECHO List of the most useful arguments for Server:
ECHO   -DEDICATED                  - Host mode where host is not a player, console appears instead
ECHO   -ROOM [ID_NUM]              - Set room specification, ID 33-standart, 28-casual, 38-Custom
ECHO   -FILE [your_add-on_file(s)] - Add ADD-ONs to game
ECHO   -GAMETYPE [gametype]        - Switches the gametype to COOP, RACE, etc.
ECHO   -WARP [MAP##] or -WARP [level_name] - Warps to suggested level
ECHO   -CONSOLE                    - Launches the additional window for console
ECHO.
ECHO For other Prompt Arguments visit: WIKI.SRB2.ORG/wiki/Command_line_parameters
SET /P SERVERline=:
ECHO Launching %SRB2_EXEC% -SERVER %SERVERline% ...
START %GAMEDIR%\%SRB2_EXEC% -SERVER %SERVERline%
GOTO MENU

:CUSTOM
CLS
ECHO  Custom launch
ECHO ===============
ECHO.
ECHO List of the most useful arguments:
ECHO   -FILE [your_add-on_file(s)] - Adds ADD-ONs to game
ECHO   -WARP [MAP##] or -WARP "[level_name]" - Warps to suggested level
ECHO   -OPENGL or -SOFTWARE        - Launches the game in OpenGL/Software renderer
ECHO   -NOMUSIC and/or -NOSOUND    - Disables all Music/Sound
ECHO   -RECORD [demofile_name]     - Records a demo, use -WARP to record specificed level
ECHO   -METAL                      - Record a demo for "Race Metal Sonic"
ECHO   -PLAYDEMO [demofile_name.lmp]   - Playbacks demo from file
ECHO   -CONSOLE                    - Launches a separate window that mirrors in-game console
ECHO.
ECHO For other Prompt Arguments visit: WIKI.SRB2.ORG/wiki/Command_line_parameters
SET /P CUSTOMline=:
ECHO Launching %SRB2_EXEC% %CUSTOMline% ...
START %GAMEDIR%\%SRB2_EXEC% %CUSTOMline%
GOTO MENU

:CONFIGedit
CLS
ECHO  CONFIG.CFG edit
ECHO =================
ECHO.
ECHO CONFIG.CFG is a file in SRB2 that contains the settings
ECHO of everything you set up in OPTIONS menu and more
ECHO.
ECHO Note: Your autoexec commands are not saved in CONFIG.CFG,
ECHO       use AUTOEXEC.CFG for that instead.
ECHO.
ECHO A Notepad window should appear with CONFIG.CFG opened.
ECHO Close that window to continue using launcher...
NOTEPAD.EXE CONFIG.CFG
GOTO MENU

:AUTOEXECedit
CLS
ECHO  AUTOEXEC.CFG edit
ECHO ===================
ECHO.
ECHO AUTOEXEC.CFG is a file that works like CONFIG.CFG, but everything stored
ECHO here is executed on each game startup as in-game console commands
ECHO.
IF EXIST AUTOEXEC.CFG (
    ECHO A Notepad window should appear with AUTOEXEC.CFG opened.
    ECHO Close that window to continue using launcher...
    NOTEPAD.EXE AUTOEXEC.CFG
) ELSE (
    ECHO AUTOEXEC.CFG does not exist. Create it manually in the same folder
    ECHO where %SRB2_EXEC% and other files are located.
    PAUSE
)
GOTO MENU

:SWITCHEXE
CLS
ECHO  Change SRB2 executable
ECHO ========================
ECHO.
ECHO Select the Executable to use.
ECHO Note that this option will not be saved next time you start the launcher.
ECHO You can change your default executable by editing SRB2_EXEC in this .BAT file.
ECHO.
ECHO 1 - Vanilla (SRB2win.exe)
ECHO 2 - TSoURDt3rd
ECHO 2 - Custom...
ECHO 3 - Back
ECHO.
CHOICE /C 123 /N /M "Select number: "
IF %ERRORLEVEL%==1 SET SRB2_EXEC=SRB2win.exe
IF %ERRORLEVEL%==2 SET /P SRB2_EXEC=Type the path to custom .EXE (current folder is %GAMEDIR%): 
IF %ERRORLEVEL%==3 GOTO MENU
GOTO MENU

:GAMEDIRFAIL
ECHO Cannot start the launcher because %GAMEDIR%, which is specified as
ECHO the SRB2 game directory, does not exist. Please edit this .BAT file and
ECHO change your GAMEDIR
PAUSE
GOTO EXIT

:EXENOTFOUND
ECHO Cannot find your %SRB2_EXEC%
ECHO Directory of SRB2 is set to %GAMEDIR%
ECHO If your game directory is different, open this file in any Text Editor
ECHO and edit the config line containing "SET GAMEDIR=" with: "SET GAMEDIR=[full_path_to_your_game_dir]"
ECHO.
ECHO Most likely your executable is renamed or completely removed. If that's the deal you should
ECHO undo your changes OR edit this .BAT and change your SRB2_EXEC
PAUSE
GOTO EXIT

:PK3NOTFOUND
ECHO Cannot find your SRB2.PK3
ECHO Directory of SRB2 is set to %GAMEDIR%
ECHO If your game directory is different, open this file in any Text Editor
ECHO and edit the config line containing "SET GAMEDIR=" with: "SET GAMEDIR=[full_path_to_your_game_dir]"
ECHO.
ECHO This is the main gamedata file and the game won't start without it. If you lost your
ECHO copy of SRB2.PK3 go to WWW.SRB2.ORG and download the file again or reinstall the game.
PAUSE

:EXIT
CLS
ECHO SRB2 batch launcher
ECHO by LeonardoTheMutant