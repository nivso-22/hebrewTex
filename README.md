# hebrewTex
docx -> LaTeX converter thats compatible with hebrew
כדי להריץ את זה צריך 
1) להתקין LaTeX בעזרת MiKTeX כולל התקנת חבילות on the fly :  https://miktex.org/howto/install-miktex
2) במסמכי docx צריך להחליף את כל ירידות השורה החלשות בחזקות על ידי:
ctrl+H
להחליף את 
"^l"
ב-
"^p"
2.1) לוודא שאין תמונות בקובץ כי אחרת זה לא מתקמפל
ולשמור מחדש
4) להתקין pandoc https://pandoc.org/installing.html5
5) להריץ את install_hebrewTex
כדי להריץ צריך ללכת לתיקיה בשורת הפקודה שבה הקובץ מאוחסן ולהקליד בשורת הפקודה:
hebrewTex "input.docx" "output.tex"
לפעמים יודפס שהקימפול נכשל אבל עדיין יווצר קובץ pdf כדרוש לכן קודם כל לבדוק

on first use/install:
1) install LaTeX via MiKTeX including installing packages on the fly: https://miktex.org/howto/install-miktex
1.1) open MiKTeX console and install all available updates
2) in .docx docs to avoid overflowing use ctrl+H in ms word or similar to to replace all "^l"(soft line breaks) with "^p"(hard line breaks)
2.1) make sure to get rid of images since they do not yet compile
3) install pandoc: https://pandoc.org/installing.html
4) execute install_hebrewTex
to execute navigate to the required directory using cmd and type:
hebrewTex "input.docx" "output.tex"
it may print that the compilation failed but a document was still produced so check the resulting file in any case
