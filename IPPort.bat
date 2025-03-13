@echo off
@title IPPort
set APP=IPPort
set AUTHOR=POMBO
set AVATAR=\Õ/
set MADE_BY=MADE BY:
set SPACE= 
set KEY=@EWEP - 2024
set HEADER=************************* IPPort *************************
set DESCRIPTION=This script tests an IP/URL and the port (optional).

:start
setlocal
COLOR F0
echo %APP%%SPACE%%MADE_BY%%SPACE%%SPACE%%AUTHOR%%SPACE%%SPACE%%AVATAR%%SPACE%%KEY%
echo.
echo %SPACE%%SPACE%%SPACE%%HEADER%
echo.
echo %SPACE%%DESCRIPTION%
echo.
timeout /t 1 /nobreak >nul

echo %SPACE%Waiting for data. . .
set "prompt=Enter an IP or URL:"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%prompt%', 'IPPort')"') do set "ip=%%i"

if "%ip%"=="" (
    cls
    COLOR F4
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%ERROR: No IP or URL entered!
    goto end
)

set "prompt=Enter the port (optional):"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%prompt%', 'IPPort')"') do set "port=%%i"

cls

if "%port%"=="" (
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%Testing %ip%. . .
    echo.
    powershell -Command "Test-NetConnection -ComputerName %ip%"
) else (
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%Testing %ip% on port %port%. . .
    echo.
    powershell -Command "Test-NetConnection -ComputerName %ip% -Port %port%"
)

echo %SPACE%Performing simple ping on %ip%. . .
powershell -Command "ping %ip%"
echo.
echo.
echo.

echo %SPACE%Tracking %ip%. . .
powershell -Command "tracert %ip%"
echo.

:end
endlocal
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Do you want to run another test?', 'IPPort', [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)" | find "Yes" >nul
if %errorlevel%==0 (
    cls
    goto start
)