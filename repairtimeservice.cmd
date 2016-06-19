@echo off

REM Don't change NTP setting if C:\aegis-ignore-ntp.txt exists
REM Allows user to prevent aegis from trashing their
REM custom NTP settings
if exist C:\aegis-ignore-ntp.txt exit

set log=^> ^%~dp0_ ^&^& type ^%~dp0_ ^&^& type ^%~dp0_ ^>^>^%~dpn0.log 2^>^&1
set logs=^>^>^%~dpn0.log 2^>^&1

goto begin

:begin
  echo [ begin repairtimeservice.cmd %date% %time% ] >"%~dpn0.log" 2>&1
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
  echo [ see repairtimeservice.log for details - any key to exit ]
  echo.
  pause >nul
  echo [ end repairtimeservice.cmd %date% %time% ] %logs%
  del /f /q "%~dp0_" >nul 2>&1
  exit

:main
  echo * stop time service ... %log%
  net stop w32time %logs%
  echo.

  echo * unregister time service ... %log%
  w32tm /unregister %logs%
  w32tm /unregister %logs%
  echo. %logs%
  echo. %log%

  echo * delete registry keys ... %log%
  set key=hkey_local_machine\software\microsoft\windows\currentversion\datetime\servers
  reg delete "%key%" /f %logs%
  set key=hkey_local_machine\system\currentcontrolset\services\w32time\timeproviders\ntpclient
  reg delete "%key%" /f /v specialpolltimeremaining %logs%
  echo. %log%

  echo * register time service ... %log%
  w32tm /register %logs%
  echo. %log%

  echo * configure time service ... %log%
  w32tm /config /syncfromflags:manual /manualpeerlist:"0.pool.ntp.org 1.pool.ntp.org 2.pool.ntp.org 3.pool.ntp.org" %logs%
  set key=hkey_local_machine\software\microsoft\windows\currentversion\datetime\servers
  reg add "%key%" /f /t reg_sz /d 0 %logs%
  reg add "%key%" /f /v 0 /t reg_sz /d 0.pool.ntp.org %logs%
  reg add "%key%" /f /v 1 /t reg_sz /d 1.pool.ntp.org %logs%
  reg add "%key%" /f /v 2 /t reg_sz /d 2.pool.ntp.org %logs%
  reg add "%key%" /f /v 3 /t reg_sz /d 3.pool.ntp.org %logs%
  set key=hkey_local_machine\system\currentcontrolset\services\w32time\timeproviders\ntpclient
  reg add "%key%" /f /v specialpollinterval /t reg_dword /d 14400 %logs%
  sc config w32time start= auto %logs%
  echo. %log%

  echo * start time service ... %log%
  net start w32time %logs%
  echo.

  echo * sync time to pool.ntp.org ... %log%
  w32tm /resync %logs%
  echo. %log%

  echo [ time service has been repaired, please reboot to complete the process ]
  echo.
  goto end

:prompt
  set /p yesno="* create system restore point? (y/n):  "
  echo.
  if /i "%yesno:~,1%" equ "y" goto rpoint
  if /i "%yesno:~,1%" equ "n" goto main
  goto prompt

:rpoint
  wmic.exe /namespace:\\root\default path systemrestore call createrestorepoint "repairtimeservice.cmd", 100, 12 %logs%
  if %errorlevel% equ 0 goto main
  set /p yesno=" !! error, failed to create system restore point. continue? (y/n):  "
  echo. %log%
  if /i "%yesno:~,1%" equ "y" goto main
  if /i "%yesno:~,1%" equ "n" goto end
