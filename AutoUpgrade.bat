@echo off
CHCP 65001>NUL
wmic path SoftwareLicensingProduct get licensestatus | 1>nul findstr "1" && goto lic || goto nolic

:lic
echo License setup version
start setup.exe /Auto Upgrade /DynamicUpdate Disable
exit /b

:nolic
FOR /F "tokens=3,4" %%I in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v EditionID') Do set "version=%%I%%J"
if "%version%" == "Professional" goto Pro
if "%version%" == "Enterprise" goto Ent
:Pro
echo Windows Professional setup version
start setup.exe /Auto Upgrade /DynamicUpdate Disable /pkey W269N-WFGWX-YVC9B-4J6C9-T83GX
exit /b
:Ent
echo Windows Enterprise setup version
start setup.exe /Auto Upgrade /DynamicUpdate Disable /pkey NPPR9-FWDCX-D2C8J-H872K-2YT43
exit /b