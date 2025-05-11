@echo off
pandoc --extract-media=. "%~1".docx -o output.md
pandoc "%~1" -o temp_output.tex --from docx --to latex --standalone --toc --number-sections --wrap=none --no-highlight --extract-media=output.md
python  C:\Users\converter.py temp_output.tex "%~2"
xelatex -interaction=nonstopmode "%~2"
pause
