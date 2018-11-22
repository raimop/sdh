@echo off & setlocal enabledelayedexpansion
:start
cls
echo Shutdown helper v1.2 by Raimo (Tallinn University OS subject homework, last updated 23 Nov 2018^)
echo To continue with the script, simply press Enter
echo To abort any previous planned shutdowns, write: a
echo For help, write: /?
echo.

:initialpart
set "initial="
set /p initial="Your wish is my command: "

if "!initial!" equ "a" (
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
goto :initialpart
)

if "!initial!" equ "" (
echo Enter pressed 
goto :mainpart
)

if "!initial!" lss 0 (
echo less than ""
goto :start
)

if "!initial!" gtr 0 (
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
set "choice="
set /p choice="Select number: "
if !choice! lss 0 (
echo Choose a number from 0 to 12, going back
goto :select
)
if !choice! gtr 12 (
echo Choose a number from 0 to 12, going back
goto :select
)


for /l %%i in (0, 1, 12) do (
if !choice! equ %%i ( 
SET /a seconds=300*%%i
SET /a minutes=!seconds!/60
echo.
echo You chose %%i, will shutdown in !seconds! seconds (!minutes! minutes^)
echo.
shutdown -s -t !time[%%i]! -c "Shutdown in !time[%%i]! seconds by SDH script (by Raimo)"
echo.
)
)

:lastchance
echo If you want to re-run this script, write: 1
echo If you are done and want to exit, simply press Enter

set "lastChance="
set /p lastChance="Choice: "

if "!lastChance!" == "1" (
goto :start
)

if "!lastChance!" == "" (
echo Goodbye^^!
timeout /t 5
goto :oef
)

if "!lastChance!" lss 0 (
goto :lastchance
)

if "!lastChance!" gtr 0 (
goto :lastchance
)

:oef