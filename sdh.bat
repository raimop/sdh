@echo off & setlocal enabledelayedexpansion
:start
cls
echo Shutdown helper v1.1 by Raimo (Tallinn University OS subject homework 18 Nov 2018, updated 21 Nov 2018^)
echo Press ENTER to continue with the script
echo To abort any previous planned shutdowns, write: a
echo For help, write: /?
echo.

:initial
set /p initial="Your wish is my command: "

if "%initial%" equ "a" (
echo Shutdown abort initiated successfully, unless shutdown prompted an error one line below this one.
echo.
shutdown -a
goto :lastchance
)

if "%initial%" equ "/?" (
echo.
echo To start the script, simply double-click sdh.bat
echo To abort any planned shutdowns, write: a
echo To prompt this help again, write: /?
echo To continue with SDH (Shutdown Helper^), simply press Enter key
echo.
goto :initial
)

if "%initial%" equ "" (
echo Enter pressed 
goto :mainpart
)

if "%initial%" lss "" (
echo less than ""
goto :start
)

if "%initial%" gtr "" (
echo greater than ""
goto :start
)

:mainpart
for /l %%i in (0, 1, 12) do (
SET /a time[%%i]=300*%%i
)

for /l %%i in (0, 1, 12) do (
set /a calc=300*%%i
set /a inMin=!calc!/60
echo shutdown in !calc! seconds (!inMin! minutes^) - select %%i
)

:select
set /p choice="Select number "
if !choice! lss 0 (
echo You have entered a number below 0, going back
goto :select
)
if !choice! gtr 12 (
echo You have entered a number above 12, going back
goto :select
)


for /l %%i in (0, 1, 12) do (
if !choice! equ %%i ( 
SET /a seconds=300*%%i
SET /a minutes=!seconds!/60
echo.
echo You chose %%i, will shutdown in !seconds! seconds (!minutes! minutes^)
shutdown -s -t !time[%%i]! -c "Shutdown in !time[%%i]! seconds by SDH script (by Raimo)" 
)
)

:lastchance
echo If you want to re-run this script, write: yes
echo If you are done and want to exit, press Enter

set /p lastChance="Choice: "

if "%lastChance%" == "yes" (
goto :start
)

if "%lastChance%" == "" (
echo Goodbye^^!
timeout /t 5
goto :oef
)

if "%lastChance%" lss "" (
goto :lastchance
)

if "%lastChance%" gtr "" (
goto :lastchance
)

:oef