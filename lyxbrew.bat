@echo off
setlocal enabledelayedexpansion

:: Get first two arguments
set "INPUT=%~1"
set "OUTPUT=%~2"
for %%f in ("%INPUT%") do set filename=%%~nf

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
pandoc --extract-media=. "%INPUT%.docx" -o output.md

:: Choose pandoc command
if "%USE_DEFAULT%"=="true" (
    echo 📄 Using default pandoc options...
    pandoc "%filename%.docx" -o "%filename%.tex" --from docx --to latex --standalone --toc --number-sections --wrap=none --no-highlight --extract-media=output.md !PANDOC_ARGS! -V lang=he
) else (
    echo 🛠 Using custom pandoc arguments...
    pandoc "%filename%.docx" -o "%filname%.tex" !PANDOC_ARGS! --standalone -V lang=he
)

:: Python post-processing
python C:\Users\converter.py "%filename%.tex" "%filename%.tex"



:: LyX
"C:/Program Files (x86)/LyX 2.3/bin/tex2lyx" -fixedenc utf8 -f "%filename%.tex"

"C:\Program Files (x86)\LyX 2.3\bin\LyX.exe" "%filename%.lyx"

pause
