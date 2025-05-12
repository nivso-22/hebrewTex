@echo off
set "MIKTEX_URL=https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-24.1-x64.exe"
set "MIKTEX_FILE=%temp%\basic-miktex.exe"

echo Downloading MiKTeX...
powershell -Command "Invoke-WebRequest -Uri '%MIKTEX_URL%' -OutFile '%MIKTEX_FILE%'"

echo Creating setupwiz.opt...
echo [Setup]> "%temp%\setupwiz.opt"
echo selected_tasks=shared>> "%temp%\setupwiz.opt"
echo auto_install=yes>> "%temp%\setupwiz.opt"
echo install_packages=on-the-fly>> "%temp%\setupwiz.opt"
echo preferred_paper=A4>> "%temp%\setupwiz.opt"

echo Installing MiKTeX...
"%MIKTEX_FILE%" --unattended --options-file="%temp%\setupwiz.opt"
