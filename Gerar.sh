#!/bin/sh

sass --update Estilo:Estilo

if [ "$1" == "html" ] || [ "$1" == "HTML" ] || [ "$1" == "HTML5" ]; then

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.html"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template=Modelo/HTML5.html \
            --citeproc \
            --toc --markdown-headings=atx --number-sections \
            --lua-filter=Extensao/Nheengatu.lua \
            --css Estilo/Nheengatu.css \
            --highlight-style=monochrome \
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
            --citeproc \
            --markdown-headings=atx --number-sections --top-level-division=section \
            --lua-filter=Extensao/Nheengatu.lua \
            --highlight-style=monochrome \
            "$arq" -f markdown -t latex -o "$novo"
        fi
    done

elif [ "$1" == "epub" ] || [ "$1" == "EPUB" ] || [ "$1" == "EPUB3" ]; then

    find . -name "*.md" ! -name "README.md" |
    while read arq; do
        novo="${arq%.*}.epub"
        if [ "$arq" -nt "$novo" ]; then
            echo "$arq -> $novo"
            pandoc \
            --standalone --template=Modelo/EPUB3.html \
            --citeproc \
            --toc --markdown-headings=atx --number-sections \
            --lua-filter=Extensao/Nheengatu.lua \
            --css Estilo/Nheengatu-EPUB.css \
            --highlight-style=monochrome \
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
            --citeproc \
            --markdown-headings=atx --number-sections --top-level-division=chapter \
            --lua-filter=Extensao/Nheengatu.lua \
            --highlight-style=monochrome \
            "$arq" -f markdown -t latex -o "$novo"
        fi
    done

else

    echo ""
    echo "Nheengatu 1.0-A5"
    echo ""
    echo "./Gerar.sh html | latex | epub | ..."
    echo "watch \"Gerar.sh html\""
    echo ""

fi
