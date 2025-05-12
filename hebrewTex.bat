@echo off
setlocal enabledelayedexpansion

:: Get first two arguments
set "INPUT=%~1"
set "OUTPUT=%~2"

:: Shift to get the rest
shift
shift

:: Default: use default options unless --custom is passed
set "USE_DEFAULT=true"
set "PANDOC_ARGS="

:: Collect remaining arguments
:collect_args
if "%~1"=="" goto run

if "%~1"=="--custom" (
    set "USE_DEFAULT=false"
) else (
    set "PANDOC_ARGS=!PANDOC_ARGS! %~1"
)
shift
goto collect_args

:run
:: Extract media
pandoc --extract-media=. "%~1%.docx" -o output.md

:: Choose pandoc command
if "%USE_DEFAULT%"=="true" (
    echo 📄 Using default pandoc options...
    pandoc "%INPUT%" -o temp_output.tex --from docx --to latex --standalone --toc --number-sections --wrap=none --no-highlight --extract-media=output.md !PANDOC_ARGS!
) else (
    echo 🛠 Using custom pandoc arguments...
    pandoc "%INPUT%" -o temp_output.tex --standalone !PANDOC_ARGS!
)

:: Python post-processing
python "Program Files (x86)\install_hebrewTex\converter.py" temp_output.tex "%OUTPUT%"

:: Compile
xelatex -interaction=nonstopmode "%OUTPUT%"

pause
