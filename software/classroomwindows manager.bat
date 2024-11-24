@echo off
::Made by PoisedProto
:menu
cls
echo ============================
echo   ClassroomWindows Manager
echo   This program lets you start and stop the ClassroomWindows process.
echo ============================
echo 1. Run process termination
echo 2. Start ClassroomWindows manually
echo 3. Exit
echo ============================
set /p choice=Select an option (1-3): 

if "%choice%"=="1" goto start
if "%choice%"=="2" goto manualstart
if "%choice%"=="3" exit
goto menu

:start
cls
echo Process termination is running.
echo Press Q at any time to return to the menu.
timeout /t 2 >nul

:loop
:: Check if the user presses Q to quit
set "keypress="
for /f "delims=" %%A in ('choice /c QN /n /t 5 /d N') do set "keypress=%%A"
if /i "%keypress%"=="Q" goto menu

:: Monitor and terminate the process
tasklist | find /i "classroomwindows.exe" >nul
if not errorlevel 1 (
    taskkill /f /im classroomwindows.exe
)
goto loop

:manualstart
cls
echo Attempting to start "classroomwindows.exe"...
start "" "C:\Program Files\Lightspeed Systems\Classroom Agent\ClassroomWindows.exe"
if errorlevel 1 (
    echo Failed to start "classroomwindows.exe". Check the file path.
) else (
    echo "classroomwindows.exe" started successfully.
)
timeout /t 3 >nul
goto menu
