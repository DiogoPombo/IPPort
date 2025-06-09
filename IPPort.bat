@echo off
@title IPPort

:start
setlocal
COLOR F0
set APP=IPPort
set AUTHOR=POMBO
set AVATAR=\\Õ/
set MADE_BY=MADE BY:
set SPACE= 
set KEY=@EWEP - 2025
set HEADER=******************** IPPort ********************
set DESCRIPTION=This script tests an IP/URL and an optional port.
set /a randNum=%random% %% 9000 + 1000
set "userAgent=IPPort%randNum%"

echo %APP%%SPACE%%MADE_BY%%SPACE%%SPACE%%AUTHOR%%SPACE%%SPACE%%AVATAR%%SPACE%%KEY%
echo.
echo %SPACE%%SPACE%%SPACE%%HEADER%
echo.
echo %SPACE%%DESCRIPTION%
echo.
timeout /t 1 /nobreak >nul

echo %SPACE%Waiting for input...
set "prompt=Enter an IP or URL:"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%prompt%', 'IPPort')"') do set "entrada=%%i"

if "%entrada%"=="" (
    cls
    COLOR F4
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%ERROR: No IP or URL entered!
    goto end
)

set "host="
echo %entrada% | findstr "http://" >nul && set "host=%entrada:~7%"
echo %entrada% | findstr "https://" >nul && set "host=%entrada:~8%"
if not defined host set "host=%entrada%"

for /f "tokens=1 delims=/" %%i in ("%host%") do set "host=%%i"

echo.
echo %SPACE%Detected host: %host%
timeout /t 1 /nobreak >nul
echo.

echo %host% | findstr /i ".onion .xyz" >nul
if %errorlevel%==0 (
    cls
    COLOR F4
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%ERROR: Potentially malicious host detected!
    goto end
)

set "prompt=Enter port (optional):"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('%prompt%', 'IPPort')"') do set "porta=%%i"

cls

if "%porta%"=="" (
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%Testing %host%...
    timeout /t 1 /nobreak >nul
    echo.
    powershell -Command "Test-NetConnection -ComputerName %host% -InformationLevel Detailed"
) else (
    echo %SPACE%%SPACE%%SPACE%%HEADER%
    echo.
    echo %SPACE%Testing %host% on port %porta%...
    timeout /t 1 /nobreak >nul
    echo.
    powershell -Command "Test-NetConnection -ComputerName %host% -Port %porta% -InformationLevel Detailed"
)

echo %SPACE%Executing simple ping on %host%...
timeout /t 1 /nobreak >nul
powershell -Command "ping %host%"
echo.
echo.
echo.

echo %SPACE%Looking up DNS...
timeout /t 1 /nobreak >nul
echo.
powershell -Command "nslookup %host%"
echo.
echo.
echo.

echo %SPACE%Executing simple curl on %entrada%...
timeout /t 1 /nobreak >nul
echo.
echo %SPACE%Generated User-Agent: %userAgent%
timeout /t 1 /nobreak >nul
echo.
curl.exe -I --max-time 120 --user-agent "%userAgent%" %entrada%
echo.
echo.
echo.

echo %SPACE%Tracing route to %host%...
timeout /t 1 /nobreak >nul
powershell -Command "tracert %host%"
echo.

:end
endlocal
timeout /t 1 /nobreak >nul


powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Do you want to perform another test?', 'IPPort', [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)" | find "Yes" >nul

if %errorlevel%==0 (
    cls
    goto start
)