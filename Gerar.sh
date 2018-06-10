#!/bin/sh

if [ "$1" == "html" ] || [ "$1" == "HTML" ] || [ "$1" == "HTML5" ]; then

    sass Estilo/Nheengatu.scss Estilo/Nheengatu.css

    find . -name "*.md" ! -name "README.md" -exec \
    pandoc \
    --standalone --template=Modelo/HTML5.html \
    --filter pandoc-citeproc \
    --toc --atx-headers --number-sections \
    --lua-filter=Extensao/Nheengatu.lua \
    --css Estilo/Nheengatu.css \
    --mathjax \
    {} -f markdown -t html5 -o {}.html \;

elif [ "$1" == "latex" ] || [ "$1" == "LaTeX" ]; then

    find . -name "*.md" ! -name "README.md" -exec \
    pandoc \
    --standalone --template=Modelo/LaTeX.tex \
    --filter pandoc-citeproc \
    --atx-headers --number-sections --top-level-division=section \
    --lua-filter=Extensao/Nheengatu.lua \
    {} -f markdown -t latex -o {}.tex \;

elif [ "$1" == "epub" ] || [ "$1" == "EPUB" ] || [ "$1" == "EPUB3" ]; then

    sass Estilo/Nheengatu-EPUB.scss Estilo/Nheengatu-EPUB.css

    find . -name "*.md" ! -name "README.md" -exec \
    pandoc \
    --standalone --template=Modelo/EPUB3.html \
    --filter pandoc-citeproc \
    --toc --atx-headers --number-sections \
    --lua-filter=Extensao/Nheengatu.lua \
    --css Estilo/Nheengatu-EPUB.css \
    {} -f markdown -t epub -o {}.epub \;

elif [ "$1" ]; then

    find . -name "*.md" ! -name "README.md" -exec \
    pandoc \
    --standalone --template="Modelo/$1.tex" \
    --filter pandoc-citeproc \
    --atx-headers --number-sections --top-level-division=chapter \
    --lua-filter=Extensao/Nheengatu.lua \
    {} -f markdown -t latex -o {}.tex \;

else

    echo "./Gerar.sh html | latex | epub | ..."

fi
