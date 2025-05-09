import re
import sys

def clean_tex_file(input_path, output_path):
    with open(input_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Remove \RL{...}
    content = re.sub(r'\\RL\{([^}]*)\}', r'\1', content)

    # 2. Replace PDFTeX conditional block
    content = re.sub(
        r'\\ifPDFTeX\\else\s+% xetex/luatex font selection',
        (
            r'\\else % if luatex or xetex\n'
            r'\\usepackage{fontspec}\n'
            r'\\usepackage{polyglossia}\n'
            r'\\setmainlanguage{hebrew}\n'
            r'\\newfontfamily\\hebrewfont[Script=Hebrew]{David}'
        ),
        content
    )

    # 3. Convert \[...\] with \\ into align*
    def convert_math(match):
        inner = match.group(1).strip()
        if '\\\\' in inner or '\n' in inner:
            return '\\begin{align*}\n' + inner + '\n\\end{align*}'
        return '\\[\n' + inner + '\n\\]'

    content = re.sub(r'\\\[(.*?)\\\]', convert_math, content, flags=re.DOTALL)

    # 4. Remove \texorpdfstring{A}{B} → A
    content = re.sub(r'\\texorpdfstring\{([^}]*)\}\{[^}]*\}', r'\1', content)

    # 5. Fix or remove invalid Unicode label references
    content = re.sub(r'\\label\{ux[0-9a-fA-Fx]*\}', '', content)

    # 6. Fix any leftover double-escaped backslashes
    content = content.replace('\\\\', r'\\')

    # 7. Optional: Remove trailing control characters
    content = re.sub(r'[^\x00-\x7F\u0590-\u05FF\s\w\{\}\\\[\]\$\^\_\-\=\+\*\/\(\)\:\;\,\.\!\?\%\&\'\"]+', '', content)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(content)

    print(f"✅ Cleaned LaTeX written to: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python converter.py input.tex output.tex")
        sys.exit(1)

    clean_tex_file(sys.argv[1], sys.argv[2])
