@echo off
pandoc "%~1" -o temp_output.tex --from docx --to latex --standalone --toc --number-sections --wrap=none --no-highlight
python  C:\Users\converter.py temp_output.tex "%~2"
xelatex -interaction=nonstopmode "%~2"
pause
