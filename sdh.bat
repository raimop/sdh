@echo off & setlocal enabledelayedexpansion
:start
cls
echo Shutdown helper v1.0 by Raimo (Tallinn University OS subject homework 18 Nov 2018^)
echo For future use, writing: "sdh a" (a as a paramater^) will abort any planned shutdowns
echo Can also write "sdh /?" for help
echo.

if "%1" equ "a" (
shutdown -a
echo.
echo Shutdown abort initiated successfully, unless shutdown prompted own error one line above this one
goto :oef
)

if "%1" equ "/?" (
echo.
echo To start the script, simply write "sdh" with no parameters
echo To abort any planned shutdowns, simply write "sdh a"
echo To prompt this help, simply write "sdh /?"
echo.
goto :oef
)

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
if !choice! equ %%i ( shutdown -s -t !time[%%i]! -c "Shutdown in !time[%%i]! seconds by SDH script (by Raimo)" )
)

:abortquestion
echo If you want to abort your option and start over, press 1, otherwise 0

set /p lastChance="Select abort number: "
echo.
if !lastChance! == 1 (
shutdown -a
echo.
echo Shutdown abort initiated successfully, unless shutdown prompted own error one line above this one
echo Starting over (continuing automatically in 20 seconds^)
timeout /t 20
goto :start
)
if !lastChance! == 0 (
goto :oef
)
if !lastChance! lss 0 (
echo You entered a number lesser than 0, returning to abort question
goto :abortquestion
)
if !lastChance! gtr 1 (
echo You entered a number greater than 1, returning to abort question
goto :abortquestion
)

:oef
echo Goodbye^^!