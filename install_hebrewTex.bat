::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSTk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlTMbCXqZg==
::ZQ05rAF9IAHYFVzEqQI4LRlGSRO2OXPa
::eg0/rx1wNQPfEVWB+kM9LVsJDA2ML3+7Crkj4O35/e+QlkgFNA==
::fBEirQZwNQPfEVWB+kM9LVsJDA2ML3+7Crkj4O35/e+QlkgFNA==
::cRolqwZ3JBvQF1fEqQIkIB4URQqRKGq2CrAOiA==
::dhA7uBVwLU+EWFeN4lE/ZUkGLA==
::YQ03rBFzNR3SWATE+k0+LXs=
::dhAmsQZ3MwfNWATE+k0+LXs=
::ZQ0/vhVqMQ3MEVWAtB9weVUEAlTMbAs=
::Zg8zqx1/OA3MEVWAtB9weVUEAlTMbAs=
::dhA7pRFwIByZRRmK+0w1SA==
::Zh4grVQjdCyDJGyX8VAjFKyq+801+NxNsX9cXyFMGl1PFYohcO0odoPU27CdHOYc5kHhZ6ok2GlOmccAMxNdfACueTsxsSBHrmHl
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal enabledelayedexpansion

:: === Config ===
set "BATFILE=hebrewTex.bat"
set "PYFILE=converter.py"
set "MIKTEX=basic-miktex-x64.exe"
set "PANDOC=pandoc.msi"
set "MIKTEX_URL=https://miktex.org/download/ctan/systems/win32/miktex/setup/windows-x64/basic-miktex-24.1-x64.exe"
set "PANDOC_URL=https://github.com/jgm/pandoc/releases/latest/download/pandoc-3.6.4-windows-x86_64.msi"
set "DL_DIR=%~dp0downloads"
set "PY_DEST=C:\hebrewTex"

:: === Prevent file name conflict ===
if /i "%~nx0"=="%MIKTEX%" (
    echo ❌ ERROR: This installer's name matches the MiKTeX file. Rename it.
    pause
    exit /b 1
)

:: === Elevate if needed ===
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 🔐 Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: === Create folders ===
if not exist "%DL_DIR%\" (
    mkdir "%DL_DIR%"
)
if not exist "%PY_DEST%\" (
    mkdir "%PY_DEST%"
)

:: === Copy files ===
if not exist "%~dp0%BATFILE%" (
    echo ❌ Missing: %BATFILE%
    pause
    exit /b 1
)
if not exist "%~dp0%PYFILE%" (
    echo ❌ Missing: %PYFILE%
    pause
    exit /b 1
)

echo 📂 Copying %BATFILE% to C:\Windows\System32...
copy /Y "%~dp0%BATFILE%" "C:\Windows\System32\"

echo 📂 Copying %PYFILE% to %PY_DEST%...
copy /Y "%~dp0%PYFILE%" "%PY_DEST%"

:: === Download MiKTeX if missing ===
if not exist "%DL_DIR%\%MIKTEX%" (
    echo 🌐 Downloading MiKTeX...
    powershell -Command "Invoke-WebRequest -Uri '%MIKTEX_URL%' -OutFile '%DL_DIR%\%MIKTEX%'"
)

:: === Ask to install MiKTeX ===
choice /M "Do you want to install MiKTeX (LaTeX)?"
if errorlevel 2 goto ask_pandoc

:: === Create setupwiz.opt config ===
echo [Setup]> "%DL_DIR%\setupwiz.opt"
echo selected_tasks=shared>> "%DL_DIR%\setupwiz.opt"
echo auto_install=yes>> "%DL_DIR%\setupwiz.opt"
echo install_packages=on-the-fly>> "%DL_DIR%\setupwiz.opt"
echo preferred_paper=A4>> "%DL_DIR%\setupwiz.opt"

:: === Run MiKTeX installer ===
echo 🛠 Installing MiKTeX...
"%DL_DIR%\%MIKTEX%" --unattended --options-file="%DL_DIR%\setupwiz.opt"

:ask_pandoc
:: === Download Pandoc if missing ===
if not exist "%DL_DIR%\%PANDOC%" (
    echo 🌐 Downloading Pandoc...
    powershell -Command "Invoke-WebRequest -Uri '%PANDOC_URL%' -OutFile '%DL_DIR%\%PANDOC%'"
)

:: === Ask to install Pandoc ===
choice /M "Do you want to install Pandoc?"
if errorlevel 2 goto done

echo 🛠 Installing Pandoc...
msiexec /i "%DL_DIR%\%PANDOC%" /quiet

:done
echo ✅ Installation complete!
pause
endlocal
