@echo off
setlocal

:: === Your filenames ===
set "BATFILE=hebrewTex.bat"
set "PYFILE=converter.py"

:: === Get user path ===
set "USERFOLDER=%USERPROFILE%"

:: === Check for admin rights ===
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 🔒 Requesting administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

:: === Check required files ===
if not exist "%~dp0%BATFILE%" (
    echo ❌ Error: %BATFILE% not found!
    pause
    exit /b 1
)
if not exist "%~dp0%PYFILE%" (
    echo ❌ Error: %PYFILE% not found!
    pause
    exit /b 1
)

:: === Copy batch file to System32 ===
echo 📁 Installing %BATFILE% to C:\Windows\System32...
copy /Y "%~dp0%BATFILE%" "C:\Windows\System32\"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to copy %BATFILE%.
    pause
    exit /b 1
)

:: === Copy Python script to user folder ===
echo 📁 Installing %PYFILE% to %USERFOLDER%...
copy /Y "%~dp0%PYFILE%" "%USERFOLDER%\"
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Failed to copy %PYFILE%.
    pause
    exit /b 1
)

echo 🎉 Installation complete!
echo 🔧 You can now run 'hebrewTex' from any command prompt.
pause
endlocal
