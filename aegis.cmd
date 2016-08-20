@echo off
set log=^> "%~dp0_" ^&^& type "%~dp0_" ^&^& type "%~dp0_" ^>^>"%~dpn0.log" 2^>^&1
set logs=^>^>"%~dpn0.log" 2^>^&1

goto begin

:begin
  echo [ begin aegis v1.18 %date% %time% ] >"%~dpn0.log" 2>&1
  echo. %log%
  echo -/- aegis v1.18 by https://voat.co/u/thepower %log%
  echo -/- visit https://tiny.cc/aegisvoat for updates %log%
  echo. %log%

  net session >nul 2>&1
  if %errorlevel% neq 0 (
    echo !! error, this script must be run as an administrator. press any key to exit ... %log%
    echo. %log%
    goto end
  ) else (
    goto prompt
  )

:end
  echo [ see aegis.log for details - any key to exit ]
  echo.
  pause >nul
  echo [ end aegis v1.18 %date% %time% ] %logs%
  del /f /q "%~dp0_" >nul 2>&1
  exit

:main
  wmic os get osarchitecture 2>&1|findstr /i 64-bit >nul 2>&1 && set setacl=setacl-64.exe || set setacl=setacl-32.exe

  :: take ownership of keys
  set key=hkey_current_user\software\policies\microsoft\office\15.0\osm
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_current_user\software\policies\microsoft\office\16.0\osm
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\microsoft\windows defender\spynet
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\sqmclient\windows
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\datacollection
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\gwx
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\scripteddiagnosticsprovider\policy
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\skydrive
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\windowsupdate
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%
  set key=hkey_local_machine\system\currentcontrolset\control\wmi\autologger\autoLogger-diagtrack-listener
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
  reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%

  echo * block bad hosts ... %log%
  start "title" /b /wait "%~dp0block.cmd" %log%
  echo. %log%

  echo * configure windows update ... %log%
  set key=hkey_local_machine\software\microsoft\windows\currentversion\windowsupdate\auto update
  reg add "%key%" /f /t reg_dword /v auoptions /d 2 %logs%
  reg add "%key%" /f /t reg_dword /v enablefeaturedsoftware /d 0 %logs%
  reg add "%key%" /f /t reg_dword /v includerecommendedupdates /d 0 %logs%
  echo. %log%

  echo * disable automated delivery of internet explorer ... %log%
  REM start "title" /b /wait "%~dp0disable7.cmd" . /B %logs%
  REM echo. %logs%
  REM start "title" /b /wait "%~dp0disable8.cmd" . /B %logs%
  REM echo. %logs%
  REM start "title" /b /wait "%~dp0disable9.cmd" . /B %logs%
  REM echo. %logs%
  REM start "title" /b /wait "%~dp0disable10.cmd" . /B %logs%
  REM echo. %logs%
  start "title" /b /wait "%~dp0disable11.cmd" . /B %logs%
  echo. %log%

  echo * disable ceip ... %log%
  set key=hkey_local_machine\software\microsoft\sqmclient\windows
  reg add "%key%" /f /t reg_dword /v ceipenable /d 0 %logs%
  echo. %log%

  echo * disable gwx ... %log%
  tasklist 2>&1 | findstr /i gwx.exe >nul 2>&1 && taskkill /f /im gwx.exe /t %logs%
  tasklist 2>&1 | findstr /i gwxux.exe >nul 2>&1 && taskkill /f /im gwxux.exe /t %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\gwx
  reg add "%key%" /f /t reg_dword /v disablegwx /d 1 %logs%
  echo. %log%

  echo * disable remote registry ... %log%
  sc query remoteregistry 2>&1 | findstr /i running >nul 2>&1 && net stop remoteregistry %logs%
  sc query remoteregistry >nul 2>&1 && sc config remoteregistry start= disabled %logs%
  echo. %log%

  echo * disable scheduled tasks ... %log%
  set tn=\microsoft\windows\application experience\aitagent
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\application experience\microsoft compatibility appraiser
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\application experience\programdataupdater
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\autochk\proxy
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\customer experience improvement program\consolidator
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\customer experience improvement program\kernelceiptask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\customer experience improvement program\usbceip
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\diskdiagnostic\microsoft-windows-diskdiagnosticdatacollector
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\maintenance\winsat
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\activatewindowssearch
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\configureinternettimeservice
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\dispatchrecoverytasks
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\ehdrminit
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\installplayready
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\mcupdate
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\mediacenterrecoverytask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\objectstorerecoverytask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\ocuractivate
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\ocurdiscovery
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\pbdadiscovery
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\pbdadiscoveryw1
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\pbdadiscoveryw2
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\pvrrecoverytask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\pvrscheduletask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\registersearch
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\reindexsearchroot
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\sqlliterecoverytask
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\media center\updaterecordpath
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\pi\sqm-tasks
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\power efficiency diagnostics\analyzeSystem
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\setup\gwx\refreshgwxconfigandcontent
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  set tn=\microsoft\windows\windows error reporting\queuereporting
  schtasks /query /tn "%tn%" >nul 2>&1 && schtasks /change /disable /tn "%tn%" %logs%
  echo. %log%

  echo * disable skydrive ... %log%
  set key=hkey_local_machine\software\policies\microsoft\windows\skydrive
  reg add "%key%" /f /t reg_dword /v disablefilesync /d 1 %logs%
  echo. %log%

  echo * disable spynet ... %log%
  set key=hkey_local_machine\software\microsoft\windows defender\spynet
  reg add "%key%" /f /t reg_dword /v spynetreporting /d 0 %logs%
  reg add "%key%" /f /t reg_dword /v submitsamplesconsent /d 0 %logs%
  echo. %log%

  echo * disable telemetry ... %log%
  set key=hkey_current_user\software\policies\microsoft\office\15.0\osm
  reg add "%key%" /f /t reg_dword /v enablelogging /d 0 %logs%
  reg add "%key%" /f /t reg_dword /v enablefileobfuscation /d 1 %logs%
  reg add "%key%" /f /t reg_dword /v enableupload /d 0 %logs%
  set key=hkey_current_user\software\policies\microsoft\office\16.0\osm
  reg add "%key%" /f /t reg_dword /v enablelogging /d 0 %logs%
  reg add "%key%" /f /t reg_dword /v enablefileobfuscation /d 1 %logs%
  reg add "%key%" /f /t reg_dword /v enableupload /d 0 %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\datacollection
  reg add "%key%" /f /t reg_dword /v allowtelemetry /d 0 %logs%
  set key=hkey_local_machine\software\policies\microsoft\windows\scripteddiagnosticsprovider\policy
  reg add "%key%" /f /t reg_dword /v enablequeryremoteserver /d 0 %logs%
  echo. %log%

  echo * disable wifisense ... %log%
  set key=hkey_local_machine\software\microsoft\wcmsvc\wifinetworkmanager
  reg add "%key%" /f /t reg_dword /v wifisensecredshared /d 0 %logs%
  reg add "%key%" /f /t reg_dword /v wifisenseopen /d 0 %logs%
  echo. %log%

  echo * disable windows 10 download ... %log%
  if exist "%systemdrive%\$windows.~bt" "%~dp0%setacl%" -on "%systemdrive%\$windows.~bt" -ot file -actn setprot -op dacl:np;sacl:nc -rec cont_obj -actn setowner -ownr n:administrators %logs%
  if exist "%systemdrive%\$windows.~bt" rmdir /q /s "%systemdrive%\$windows.~bt" %logs%
  REM mkdir "%systemdrive%\$windows.~bt" %logs%
  REM attrib +h "%systemdrive%\$windows.~bt" %logs%
  REM "%~dp0%setacl%" -on "%systemdrive%\$windows.~bt" -ot file -actn setprot -op dacl:p_nc;sacl:p_nc -rec cont_obj -actn setowner -ownr n:administrators %logs%
  echo. %log%

  echo * disable windows 10 upgrade ... %log%
  set key=hkey_local_machine\software\policies\microsoft\windows\windowsupdate
  reg add "%key%" /f /t reg_dword /v disableosupgrade /d 1 %logs%
  echo. %log%

  echo * remove diagtrack ... %log%
  sc query diagtrack 2>&1 | findstr /i running >nul 2>&1 && net stop diagtrack %logs%
  sc query diagtrack >nul 2>&1 && sc delete diagtrack %logs%
  echo. %log%

  if exist C:\aegis-change-ntp.txt (
    echo * sync time to pool.ntp.org ... %log%

    set key=hkey_local_machine\system\currentcontrolset\services\w32time\parameters
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%

    set key=hkey_local_machine\software\microsoft\windows\currentversion\datetime\servers
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%

    set key=hkey_local_machine\system\currentcontrolset\services\w32time\timeproviders\ntpclient
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn setowner -ownr n:administrators %logs%
    reg query "%key%" >nul 2>&1 && "%~dp0%setacl%" -on "%key%" -ot reg -actn ace -ace "n:administrators;p:full" %logs%

    sc query w32time 2>&1 | findstr /i running >nul 2>&1 && net stop w32time %logs%
    set key=hkey_local_machine\software\microsoft\windows\currentversion\datetime\servers
    reg query "%key%" >nul 2>&1 && reg delete "%key%" /f %logs%
    set key=hkey_local_machine\system\currentcontrolset\services\w32time\timeproviders\ntpclient
    reg query "%key%" >nul 2>&1 && reg delete "%key%" /f /v specialpolltimeremaining %logs%
    w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" %logs%
    set key=hkey_local_machine\software\microsoft\windows\currentversion\datetime\servers
    reg add "%key%" /f /t reg_sz /d 0 %logs%
    reg add "%key%" /f /t reg_sz /v 0 /d 0.pool.ntp.org %logs%
    reg add "%key%" /f /t reg_sz /v 1 /d 1.pool.ntp.org %logs%
    reg add "%key%" /f /t reg_sz /v 2 /d 2.pool.ntp.org %logs%
    reg add "%key%" /f /t reg_sz /v 3 /d 3.pool.ntp.org %logs%
    set key=hkey_local_machine\system\currentcontrolset\services\w32time\timeproviders\ntpclient
    reg add "%key%" /f /t reg_dword /v specialpollinterval /d 14400 %logs%
    sc config w32time start= auto %logs%
    net start w32time %logs%
    w32tm /resync %logs%
    echo. %log%
  )

  echo * uninstall ^& hide updates (this may take a while, be patient) ... %log%
  powershell -executionpolicy bypass -file "%~dp0uninstall.ps1" %log%
  powershell -executionpolicy bypass -file "%~dp0hide.ps1" %log%
  sc query wuauserv 2>&1 | findstr /i running >nul 2>&1 && net stop wuauserv %logs%
  sc query bits 2>&1 | findstr /i running >nul 2>&1 && net stop bits %logs%
  net start bits %logs%
  net start wuauserv %logs%
  echo.
  goto end

:prompt
  set /p yesno="* create system restore point? (y/n):  "
  echo.
  if /i "%yesno:~,1%" equ "y" goto rpoint
  if /i "%yesno:~,1%" equ "n" goto main
  goto prompt

:rpoint
  wmic.exe /namespace:\\root\default path systemrestore call createrestorepoint "aegis v1.18", 100, 12 %logs%
  if %errorlevel% equ 0 goto main
  set /p yesno=" !! error, failed to create system restore point. continue? (y/n):  "
  echo. %log%
  if /i "%yesno:~,1%" equ "y" goto main
  if /i "%yesno:~,1%" equ "n" goto end
