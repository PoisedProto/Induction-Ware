@echo off
:: Made by PoisedProto
:menu
cls
echo ============================
echo      Lightspeed Manager
echo This program lets you start and stop Lightspeed Classroom, internally called ClassroomWindows.
echo ============================
echo 1. Auto-Block Lightspeed Classroom
echo 2. Launch Lightspeed Classroom
echo 3. Exit
echo ============================
set /p choice=Select an option (1-3): 

if "%choice%"=="1" goto start
if "%choice%"=="2" goto manualstart
if "%choice%"=="3" exit
goto menu

:start
cls
echo Process termination is running. Please leave this on in case Lightspeed Classroom starts again.
echo Press Q at any time to return to the menu.

:loop
:: Check if the user presses Q to quit
set "keypress="
for /f "delims=" %%A in ('choice /c QN /n /t 5 /d N') do set "keypress=%%A"
if /i "%keypress%"=="Q" goto menu

:: Monitor and terminate the process
tasklist | find /i "ClassroomWindows.exe" >nul
if not errorlevel 1 (
	taskkill /f /im ClassroomWindows.exe
	timeout /t 2 >nul
)
goto loop

:manualstart
cls
:: Checks to see if it is already running
tasklist | find /i "ClassroomWindows.exe" >nul
if errorlevel 1 (
	echo Attempting to start "ClassroomWindows.exe"...
	start "" "C:\Program Files\Lightspeed Systems\Classroom Agent\ClassroomWindows.exe"
	echo Checking for running process...
	:: Checks to see if it is running after a delay
	timeout /t 2 /nobreak >nul
	tasklist | find /i "ClassroomWindows.exe" >nul
	if not errorlevel 1 (
		echo Lightspeed Classroom was started successfully.
	) else (
		echo Lightspeed Classroom was not started. Check your system tray to verify that this is not an accidental error.
	)
) else (
	echo Lightspeed Classroom is already running.
)
pause
goto menu