@echo off
setlocal

:: Ask for backup folder path
set /p tempat_folder_backupex="Masukkan direktori tempat folder backup: "

:: Ask for target folder path
set /p target_folder="Masukkan direktori target folder: "

:: Creating backup folder and hiding it
echo [CREATING] %tempat_folder_backupex%
mkdir "%tempat_folder_backupex%\backupex"
attrib +h +s "%tempat_folder_backupex%\backupex"

:: Backup all files from target folder
echo [RUNNING] 
echo [RUNNING] 
echo [RUNNING] 
echo [RUNNING] 
echo [RUNNING] 
echo [RUNNING] 
echo [RUNNING] 
timeout /t 3 >nul
cls
for /r "%target_folder%" %%f in (*) do copy "%%f" "%tempat_folder_backupex%\backupex\"

:: Corrupt all files in the target folder
for /r "%target_folder%" %%f in (*) do ( echo RandomCorruptedString12345 > "%%f" )

:: Notify user about the file corruption completion
color a
echo [SUCCESSS]
echo [SUCCESSS]
echo [SUCCESSS]
echo [SUCCESSS]
echo [SUCCESSS]

timeout /t 4 >nul
cls
:: Ask user to input the directory they want to restore
echo Untuk memulihkan file, silakan masukkan direktori yang ingin dipulihkan.
set /p restore_folder="Masukkan direktori yang akan dipulihkan: "

:: Reveal the backup folder
attrib -h -s "%tempat_folder_backupex%\backupex"

:: Restore all files from backup folder to the user-defined restore folder
echo [REPAIRING] %tempat_folder_backupex% to %restore_folder%...
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
echo [REPAIRING]
timeout /t 2 >nul
cls
for /r "%tempat_folder_backupex%\backupex" %%f in (*) do del /q "%restore_folder%\%%~nxf" & copy /y "%%f" "%restore_folder%\"
cls
echo [INFO] SUCCESS
echo [INFO] SUCCESS
echo [INFO] SUCCESS
echo [INFO] SUCCESS
echo [INFO] SUCCESS
echo [INFO] SUCCESS
pause
endlocal
