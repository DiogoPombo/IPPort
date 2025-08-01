@echo off
@title IPPort

:start
chcp 65001 > nul
setlocal EnableDelayedExpansion
COLOR F0
set APP=IPPort
set AUTHOR=POMBO
set AVATAR=\Õ/
set MADE_BY=MADE BY:
set SPACE= 
set KEY=@EWEP - 2025
set /a randNum=%random% %% 9000 + 1000
set "userAgent=IPPort_!randNum!"


for /f "tokens=3" %%I in ('reg query "HKEY_CURRENT_USER\Control Panel\International" /v LocaleName') do set "LANGUAGE=%%I"
set "LANG_PREFIX=%LANGUAGE:~0,2%"
if /i "%LANG_PREFIX%"=="pt" (
    set "IDIOMA=PT"
) else (
    set "IDIOMA=EN"
)


if "%IDIOMA%"=="PT" (
    set "MSG_HEADER=******************** IPPort ********************"
    set "MSG_DESCRIPTION=Esse script testa um IP/URL e a porta (opcional)."
    set "MSG_DESCRIPTIONIPV6=Para testar um IP do tipo IPv6 coloque-o entre colchetes! Exemplo: [XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX]"
    set "MSG_WAITING=Aguardando dados. . ."
    set "MSG_PROMPT_IP=Digite um IP ou URL:"
    set "MSG_ERROR_NO_INPUT=ERRO: Nenhum IP ou URL inserido!"
    set "MSG_HOST_DETECTED=Host detectado:"
    set "MSG_ERROR_MALICIOUS=ERRO: Host potencialmente malicioso detectado!"
    set "MSG_PROMPT_PORT=Digite a porta (opcional):"
    set "MSG_TESTING=Testando"
    set "MSG_ON_PORT=na porta"
    set "MSG_PING=Executando ping simples em"
    set "MSG_DNS=Procurando por DNS. . ."
    set "MSG_CURL=Executando curl simples em"
    set "MSG_TRACE=Executando trace em"
    set "MSG_USER_AGENT=User-Agent gerado:"
    set "MSG_ANOTHER_TEST=Deseja executar outro teste?"
) else (
    set "MSG_HEADER=******************** IPPort ********************"
    set "MSG_DESCRIPTION=This script tests an IP/URL and an optional port."
    set "MSG_DESCRIPTIONIPV6=To test an IPv6 address, enclose it in brackets! Example: [XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX:XXXX]"
    set "MSG_WAITING=Waiting for input. . ."
    set "MSG_PROMPT_IP=Enter an IP or URL:"
    set "MSG_ERROR_NO_INPUT=ERROR: No IP or URL entered!"
    set "MSG_HOST_DETECTED=Detected host:"
    set "MSG_ERROR_MALICIOUS=ERROR: Potentially malicious host detected!"
    set "MSG_PROMPT_PORT=Enter a port (optional):"
    set "MSG_TESTING=Testing"
    set "MSG_ON_PORT=on port"
    set "MSG_PING=Running simple ping to"
    set "MSG_DNS=Looking up DNS. . ."
    set "MSG_CURL=Running simple curl to"
    set "MSG_TRACE=Running trace to"
    set "MSG_USER_AGENT=Generated User-Agent:"
    set "MSG_ANOTHER_TEST=Do you want to run another test?"
)

echo !APP!!SPACE!!MADE_BY!!SPACE!!SPACE!!AUTHOR!!SPACE!!SPACE!!AVATAR!!SPACE!!KEY!
echo.
echo !SPACE!!SPACE!!SPACE!!MSG_HEADER!
echo.
echo !SPACE!!MSG_DESCRIPTION!
echo.
echo !SPACE!!MSG_DESCRIPTIONIPV6!
echo.
timeout /t 1 /nobreak >nul

echo !SPACE!!MSG_WAITING!
set "prompt=!MSG_PROMPT_IP!"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('!prompt!', 'IPPort')"') do set entrada=%%i

if "!entrada!"=="" (
 cls
 COLOR F4
 echo !SPACE!!SPACE!!SPACE!!MSG_HEADER!
 echo.
 echo !SPACE!!MSG_ERROR_NO_INPUT!
 goto end
)

set "entrada=!entrada:^=^^!"
set "entrada=!entrada:&=^&!"
set "entrada=!entrada:|=^|!"
set "entrada:<=^<!"
set "entrada:>=^>!"
set "entrada:`=``!"
set "entrada:'=''!"

set "host="
echo !entrada! | findstr "http://" >nul && set "host=!entrada:~7!"
echo !entrada! | findstr "https://" >nul && set "host=!entrada:~8!"
if not defined host set "host=!entrada!"

for /f "tokens=1 delims=/" %%i in ("!host!") do set "host=%%i"

echo.
echo !SPACE!!MSG_HOST_DETECTED! !host!
timeout /t 1 /nobreak >nul
echo.

echo !host! | findstr /i ".onion .xyz" >nul
if !errorlevel!==0 (
 cls
 COLOR F4
 echo !SPACE!!SPACE!!SPACE!!MSG_HEADER!
 echo.
 echo !SPACE!!MSG_ERROR_MALICIOUS!
 goto end
)

set "prompt=!MSG_PROMPT_PORT!"
for /f "tokens=*" %%i in ('powershell -Command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('!prompt!', 'IPPort')"') do set porta=%%i

chcp 850 > nul

cls
timeout /t 1 /nobreak >nul
cls

if "!porta!"=="" (
 echo !SPACE!!SPACE!!SPACE!!MSG_HEADER!
 echo.
 echo !SPACE!!MSG_TESTING! !host!. . .
 timeout /t 1 /nobreak >nul
 echo.
 powershell -Command "Test-NetConnection -ComputerName '!host!' -InformationLevel Detailed"
) else (
 echo !SPACE!!SPACE!!SPACE!!MSG_HEADER!
 echo.
 echo !SPACE!!MSG_TESTING! !host! !MSG_ON_PORT! !porta!. . .
 timeout /t 1 /nobreak >nul
 echo.
 powershell -Command "Test-NetConnection -ComputerName '!host!' -Port !porta! -InformationLevel Detailed"
)

echo !SPACE!!MSG_PING! !host!. . .
timeout /t 1 /nobreak >nul
powershell -Command "ping !host!"
echo.
echo.
echo.

echo !SPACE!!MSG_DNS!
timeout /t 1 /nobreak >nul
echo.
powershell -Command "nslookup !host!"
echo.
echo.
echo.

if "!porta!"=="" (
    echo !SPACE!!MSG_CURL! !entrada!. . .
    timeout /t 1 /nobreak >nul
    echo.
    echo !SPACE!!MSG_USER_AGENT! !userAgent!
    timeout /t 1 /nobreak >nul
    echo.
    powershell -Command "curl.exe -I --max-time 120 --user-agent '!userAgent!' '!entrada!' | Out-Host"
    echo.
    echo.
    echo.
) else (
    echo !SPACE!!MSG_CURL! !entrada! !MSG_ON_PORT! !porta!. . .
    timeout /t 1 /nobreak >nul
    echo.
    echo !SPACE!!MSG_USER_AGENT! !userAgent!
    timeout /t 1 /nobreak >nul
    echo.
    powershell -Command "curl.exe -I --max-time 120 --user-agent '!userAgent!' '!entrada!:!porta!' | Out-Host"
    echo.
    echo.
    echo.
)

echo !SPACE!!MSG_TRACE! !host!. . .
timeout /t 1 /nobreak >nul
powershell -Command "tracert !host!"
echo.

:end
timeout /t 1 /nobreak >nul
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('!MSG_ANOTHER_TEST!', 'IPPort', [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)" | find "Yes" >nul

if %errorlevel%==0 (
 cls
 endlocal
 cls
 goto start
)

cls
endlocal
exit