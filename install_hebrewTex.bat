@echo off
setlocal

:: === CONFIGURABLE FILE NAMES ===
set "BATFILE=hebrewTex.bat"
set "PYFILE=converter.py"
set "MIKTEX=miktexsetup.exe"
set "PANDOC=pandoc.msi"

:: === Get user home directory ===
set "USERDIR=%USERPROFILE%"

:: === Check for admin privileges ===
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 🔐 Requesting administrator rights...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: === Copy core files ===
if not exist "%~dp0%BATFILE%" (
    echo ❌ Missing file: %BATFILE%
    pause
    exit /b 1
)
if not exist "%~dp0%PYFILE%" (
    echo ❌ Missing file: %PYFILE%
    pause
    exit /b 1
)

echo 📂 Installing %BATFILE% to C:\Windows\System32...
copy /Y "%~dp0%BATFILE%" "C:\Windows\System32\"

echo 📂 Copying %PYFILE% to %USERDIR%...
copy /Y "%~dp0%PYFILE%" "%USERDIR%"

:: === Ask user about MiKTeX installation ===
choice /M "Do you want to install MiKTeX?"
if errorlevel 2 goto ask_pandoc

if not exist "%~dp0%MIKTEX%" (
    echo ❌ Missing %MIKTEX%. Please place it in the same folder.
    goto ask_pandoc
)

echo 🛠 Installing MiKTeX...
"%~dp0%MIKTEX%" --quiet install
initexmf --admin --set-config-value [MPM]AutoInstall=1

:ask_pandoc
choice /M "Do you want to install Pandoc?"
if errorlevel 2 goto done

if not exist "%~dp0%PANDOC%" (
    echo ❌ Missing %PANDOC%. Please place it in the same folder.
    goto done
)

echo 🛠 Installing Pandoc...
msiexec /i "%~dp0%PANDOC%" /quiet

:done
echo ✅ Installation completed.
pause
endlocal
