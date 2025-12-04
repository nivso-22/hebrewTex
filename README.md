# hebrewTex
docx -> LaTeX converter thats compatible with hebrew

כדי להריץ את זה צריך:
להריץ את install_hebrewTex ולאשר לו לתהקין את התוכנות לבד, או:

1) להתקין LaTeX בעזרת MiKTeX כולל התקנת חבילות on the fly :  https://miktex.org/howto/install-miktex

1.1) לוודא ב MiKTeX console שכל העדכונים הדרשוים מותקנים

2) במסמכי docx צריך להחליף את כל ירידות השורה החלשות בחזקות על ידי:
ctrl+H
להחליף את 
"^l"
ב-
"^p"


3) להתקין pandoc https://pandoc.org/installing.html5

4) להריץ את install_hebrewTex
   
כדי להריץ צריך ללכת לתיקיה בשורת הפקודה שבה הקובץ מאוחסן ולהקליד בשורת הפקודה:
hebrewTex "input.docx" "output.tex"
לפעמים יודפס שהקימפול נכשל אבל עדיין יווצר קובץ pdf כדרוש לכן קודם כל לבדוק
אם לא עובד אפשר להעתיק את הקובץ "hebrewTex.bat" מהתיקיה שהורדתם אל תוך system32 ולהחליף את הקובץ הקיים שם

on first use/install:
run install_hebrewTex and let it aut-install requirements, or:
1) install LaTeX via MiKTeX including installing packages on the fly: https://miktex.org/howto/install-miktex

1.1) open MiKTeX console and install all available updates

2) in .docx docs to avoid overflowing use ctrl+H in ms word or similar to to replace all "^l"(soft line breaks) with "^p"(hard line breaks)


3) install pandoc: https://pandoc.org/installing.html

4) execute install_hebrewTex
to execute navigate to the required directory using cmd and type:
hebrewTex "input.docx" "output.tex"
it may print that the compilation failed but a document was still produced so check the resulting file in any case


this has been approved by microsoft in the request with id:fcf680c5-c667-42b7-b08c-06f200470d49
