@echo off
:: Made by PoisedProto
:menu
cls
echo ============================
echo   Lightspeed Manager v1.03
echo This program lets you start and stop Lightspeed Classroom, internally called ClassroomWindows.
echo ============================
echo 1. Auto-Close Lightspeed Classroom
echo 2. Launch Lightspeed Classroom
echo ============================

:: Warn user if Neutrino is already running.
tasklist | find /i "neutrino.exe" >nul || tasklist | find /i "nutrino.exe" >nul
if not errorlevel 1 (
	echo WARNING: Neutrino is running in the background too! This can cause problems.
	echo 3. Close Neutrino
)
set /p choice=Select an option (number keys): 

if "%choice%"=="1" goto start
if "%choice%"=="2" goto manualstart
if "%choice%"=="3" goto manualstopneutrino
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
	:: Closes Neutrino if it is running
	tasklist | find /i "neutrino.exe" >nul || tasklist | find /i "nutrino.exe" >nul
	if not errorlevel 1 (
		echo Closing Neutrino.
		goto autostopneutrino
	)
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

:manualstopneutrino
:: For the menu
cls
taskkill /f /im Neutrino.exe
taskkill /f /im Nutrino.exe
pause
goto menu

:autostopneutrino
:: For when you start Lightspeed manually
taskkill /f /im Neutrino.exe
taskkill /f /im Nutrino.exe
timeout /t 2 /nobreak >nul
goto manualstart