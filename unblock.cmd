@echo off

route print 2>nul >routes.tmp

FOR /F %%I IN (%~dp0block-ip.txt) DO (
  findstr %%I routes.tmp >nul 2>&1
  if %errorlevel% equ 0 (
    route delete %%I >nul 2>&1
    echo  - unblocked 2.21.16.151
  )
)

FOR /F %%I IN (%~dp0block-domain.txt) DO (
  findstr " %%I" %systemdrive%\windows\system32\drivers\etc\hosts >nul 2>&1
  if %errorlevel% equ 0 (
    "%~dp0sed.exe" -i "/%%I/d" "%systemdrive%\windows\system32\drivers\etc\hosts" >nul 2>&1
    echo  - unblocked %%I
  )
)

del /f /q routes.tmp >nul 2>&1
exit

:: Modifying the hosts file would be much easier and faster 
:: if grep.exe were available as well as sed.exe
::
:: For example:
::
:: set sed="%~dp0sed.exe"
:: set grep="%~dp0grep.exe"
:: set bd="%~dp0block-domain.txt"
:: set hf="%systemdrive%\windows\system32\drivers\etc\hosts"
:: set t1=hosts1.tmp
:: set t2=hosts2.tmp
::
:: :: ignore comments and blank lines in block-domain.txt
:: "%sed%" -e 's/#.*//; /^[[:space:]]*$/d' "%bd" > "%t1"
::
:: :: create a sed script to run against the hosts file
:: :: **MUCH** faster than running sed.exe hundreds of times in a FOR loop
:: "%grep" -o -F -f "%t1" "%hf" | "%sed%" -e 's:%:/:; s:$:/d:' > "%t2"
::
:: :: do it
:: "%sed%" -i -f "%t2" "%hf"
::
:: :: tell user what we've done
:: "%sed%" -e 's/^/ - unblocked /' "%t1"
::
:: :: clean up
:: delete /Q "%t1" "%t2"

