@ECHO OFF
TITLE RPA/RPYC decompiler
:: This creates necessary subfolders if they dont exist
IF NOT EXIST "%CD%\01_Input_RPA" MKDIR "%CD%\01_Input_RPA"
IF NOT EXIST "%CD%\02_Output_RPA" MKDIR "%CD%\02_Output_RPA"
IF NOT EXIST "%CD%\03_Input_RPYC" MKDIR "%CD%\03_Input_RPYC"
IF NOT EXIST "%CD%\04_Output_RPYC" MKDIR "%CD%\04_Output_RPYC"

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + Start menu
:Menu
ECHO.
ECHO =============================== THIS IS DECOMPILER MENU =================================
ECHO.
ECHO "(1) Run RPA decompiler"
ECHO "(2) Run RPYC decompiler"
ECHO "(3) Copy all .RPA from game folder"
ECHO "(4) Clean all subfolders"
ECHO "(5) Exit"
ECHO.
SET /p m_input=Type option nr.:
IF "%m_input%"=="1" GOTO:RPA_deco
IF "%m_input%"=="2" GOTO:RPYC_deco
IF "%m_input%"=="3" GOTO:Pull
IF "%m_input%"=="4" GOTO:Clean
IF "%m_input%"=="5" GOTO:Exit

ECHO.
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! Incorrect input ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
pause
GOTO:Menu

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + Pull RPA files from game folder
:Pull
ECHO.
ECHO =============================== COPY .RPA FILES FROM ... ================================
ECHO.
SET /p game_input=Paste game path here (where .exe is):
ROBOCOPY %game_input%\game %CD%\01_Input_RPA *.rpa /NJS /NJH
ECHO.
ECHO ---------------------- COPYING .RPA FILES IS DONE - GOING TO MENU ----------------------
ECHO.
GOTO Menu

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + Clean all subfolders
:Clean
ECHO.
ECHO ========================= CLEAN ALL SUBFOLDERS IN RENPY_DECO ============================
ECHO.
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! WARNING ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
ECHO.
ECHO You are about to delete all files from folders:
ECHO \01_Input_RPA
ECHO \02_Output_RPA
ECHO \03_Input_RPYC
ECHO \04_Output_RPYC
ECHO.
SET /p delete=Do you want to continue? [Y]es [N]o:
IF "%delete%"=="Y" GOTO:Del_Y
IF "%delete%"=="y" GOTO:Del_Y
IF "%delete%"=="N" GOTO:Del_N
IF "%delete%"=="n" GOTO:Del_N

ECHO.
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! Incorrect input ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
GOTO:Clean

:Del_Y
ECHO.
ECHO ---------------------------------- Deleting all files ----------------------------------
ECHO.
RMDIR /s /q "%CD%\01_Input_RPA"
MKDIR "%CD%\01_Input_RPA"
RMDIR /s /q "%CD%\02_Output_RPA"
MKDIR "%CD%\02_Output_RPA"
RMDIR /s /q "%CD%\03_Input_RPYC"
MKDIR "%CD%\03_Input_RPYC"
RMDIR /s /q "%CD%\04_Output_RPYC"
MKDIR "%CD%\04_Output_RPYC"
ECHO.
ECHO -------------------------------- Deleting files - DONE ----------------------------------
ECHO.
GOTO:Menu

:Del_N
ECHO.
ECHO ----------------------- File deletion was cancled. Going to menu ------------------------
ECHO.
GOTO:Menu

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + RPA decompress
:RPA_deco
ECHO.
ECHO ================================ THIS IS RPA DECOMPILER ================================
ECHO.
ECHO List of .rpa files in input folder:
DIR %CD%\01_Input_RPA /b *.rpa 2>nul
ECHO.
ECHO ----------------------------------------------------------------------------------------
ECHO.
ECHO Input file name
SET /P file_rpa="File to decompile:"
ECHO You chose %file_rpa%.rpa to decompile.
ECHO.
ECHO ----------------------------------------------------------------------------------------
ECHO.
py -3 -m unrpa -mp "%CD%\02_Output_RPA" "%CD%\01_Input_RPA\%file_rpa%.rpa"
ECHO.
ECHO --------------------------- DECOMPILING RPA FILE IS DONE -------------------------------
ECHO -------------------------- OUTPUT FOLDER - 02_Output_RPA -------------------------------
ECHO.
ECHO "(1) Decompile new RPA file"
ECHO "(2) Run RPYC decompiler"
ECHO "(3) Exit"
ECHO.
SET /p rpa_input=Type option nr.:
IF "%rpa_input%"=="1" GOTO:RPA_deco
IF "%rpa_input%"=="2" GOTO:RPYC_deco
IF "%rpa_input%"=="3" GOTO:Exit

ECHO.
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! Incorrect input ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
pause
GOTO:RPA_deco

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + RPYC decompress
:RPYC_deco
ECHO.
ECHO ============================= THIS IS RPYC DECOMPILER ===================================
ECHO.
ECHO "(1) Decompile and copy all *.rpyc files from <02_Output_RPA> folder"
ECHO "(2) Decompile and copy all *.rpyc files from <03_Input_RPYC> folder"
ECHO.
SET /p rpyc_input_data=Type option nr.:
IF "%rpyc_input_data%"=="1" GOTO Output_RPA
IF "%rpyc_input_data%"=="2" GOTO Input_RPYC
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! Incorrect input ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
pause
GOTO:RPA_deco

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
:Output_RPA
%CD%\unrpyc\unrpyc.py %CD%\02_Output_RPA
ROBOCOPY %CD%\02_Output_RPA %CD%\04_Output_RPYC *.rpy /XF *.rpyc /MOVE /S /E /NJS /NJH
GOTO RPYC_end

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
:Input_RPYC
%CD%\unrpyc\unrpyc.py %CD%\03_Input_RPYC
ROBOCOPY %CD%\03_Input_RPYC %CD%\04_Output_RPYC *.rpy /XF *.rpyc /MOVE /S /E /NJS /NJH
GOTO RPYC_end

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - +
:RPYC_end
ECHO.
ECHO ------------------------ DECOMPILING RPYC FILE/S IS DONE --------------------------------
ECHO ------------------------ OUTPUT FOLDER - 04_Output_RPYC ---------------------------------
ECHO.
ECHO "(1) Decompile new RPYC file/s"
ECHO "(2) Run RPA decompiler"
ECHO "(3) Exit"
ECHO.
SET /p rpyc_input=Type option nr.:
IF "%rpyc_input%"=="1" GOTO:RPYC_deco
IF "%rpyc_input%"=="2" GOTO:RPA_deco
IF "%rpyc_input%"=="3" GOTO:Exit

ECHO.
ECHO ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! Incorrect input ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! !
pause
GOTO:RPYC_deco

:: - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + - + Exit
:Exit
ECHO.
ECHO ================================ PRESS ANY KEY TO EXIT =================================
ECHO.
pause
