@echo off
setlocal

REM Direktori target
set targetDir=C:\Users\lenov\OneDrive\Dokumen

REM Token untuk mengembalikan file
set secretToken=1234

REM Menyembunyikan semua file dan folder di %targetDir%
echo Menyembunyikan semua file dan folder di %targetDir%
attrib +h /s /d "%targetDir%\*"
echo Semua file dan folder telah disembunyikan!

REM Menghapus izin akses untuk semua pengguna
icacls "%targetDir%\*" /inheritance:r /grant:r "Administrators":F /grant:r "SYSTEM":F /deny "Users":F
echo Semua file dan folder telah diakses secara terbatas!

:askToken
echo.
set /p userToken="Masukkan token untuk mengembalikan file: "

if "%userToken%"=="%secretToken%" (
    echo Token benar. Mengembalikan semua file dan folder di %targetDir%
    
    REM Mengembalikan izin akses untuk semua pengguna
    icacls "%targetDir%\*" /reset /T
    if errorlevel 1 (
        echo Gagal mengembalikan izin akses. Pastikan Anda menjalankan skrip ini sebagai administrator.
        pause
        exit /b
    )

    REM Mengembalikan atribut file
    attrib -h /s /d "%targetDir%\*"
    if errorlevel 1 (
        echo Gagal mengembalikan file dan folder. Pastikan Anda menjalankan skrip ini sebagai administrator.
        pause
        exit /b
    )
    
    echo Semua file dan folder telah dikembalikan!
) else (
    echo Token salah! Coba lagi.
    goto askToken
)

echo.
echo Tekan tombol apa saja untuk keluar...
pause > nul
