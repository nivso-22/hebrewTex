@echo off
set "PANDOC_URL=https://github.com/jgm/pandoc/releases/latest/download/pandoc-3.1.11.1-windows-x86_64.msi"
set "PANDOC_FILE=%temp%\pandoc.msi"

echo Downloading Pandoc...
powershell -Command "Invoke-WebRequest -Uri '%PANDOC_URL%' -OutFile '%PANDOC_FILE%'"

echo Installing Pandoc...
msiexec /i "%PANDOC_FILE%" /quiet
