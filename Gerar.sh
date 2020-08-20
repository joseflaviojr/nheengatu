#!/bin/sh

if [ "$1" == "html" ] || [ "$1" == "HTML" ] || [ "$1" == "HTML5" ]; then

    sass --update Estilo/Nheengatu.scss Estilo/Nheengatu.css

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.html"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template=Modelo/HTML5.html \
            --filter pandoc-citeproc \
            --toc --atx-headers --number-sections \
            --lua-filter=Extensao/Nheengatu.lua \
            --css Estilo/Nheengatu.css \
            "$arq" -f markdown -t html5 -o "$novo"
        fi
    done

elif [ "$1" == "tex" ] || [ "$1" == "latex" ] || [ "$1" == "LaTeX" ]; then

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.tex"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template=Modelo/LaTeX.tex \
            --filter pandoc-citeproc \
            --atx-headers --number-sections --top-level-division=section \
            --lua-filter=Extensao/Nheengatu.lua \
            "$arq" -f markdown -t latex -o "$novo"
        fi
    done

elif [ "$1" == "epub" ] || [ "$1" == "EPUB" ] || [ "$1" == "EPUB3" ]; then

    sass --update Estilo/Nheengatu-EPUB.scss Estilo/Nheengatu-EPUB.css

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.epub"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template=Modelo/EPUB3.html \
            --filter pandoc-citeproc \
            --toc --atx-headers --number-sections \
            --lua-filter=Extensao/Nheengatu.lua \
            --css Estilo/Nheengatu-EPUB.css \
            "$arq" -f markdown -t epub -o "$novo"
        fi
    done

elif [ "$1" ]; then

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.tex"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template="Modelo/$1.tex" \
            --filter pandoc-citeproc \
            --atx-headers --number-sections --top-level-division=chapter \
            --lua-filter=Extensao/Nheengatu.lua \
            "$arq" -f markdown -t latex -o "$novo"
        fi
    done

else

    echo ""
    echo "Nheengatu 1.0-A4"
    echo ""
    echo "./Gerar.sh html | latex | epub | ..."
    echo "watch \"Gerar.sh html\""
    echo ""

fi
