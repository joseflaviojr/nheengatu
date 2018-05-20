#!/bin/sh

sass Estilo/Nheengatu-EPUB.scss Estilo/Nheengatu-EPUB.css

find . -name "*.md" ! -name "README.md" -exec \
pandoc \
--standalone --template=Modelo/EPUB3.html \
--filter pandoc-citeproc \
--toc --atx-headers --number-sections \
--lua-filter=Extensao/Nheengatu.lua \
--css Estilo/Nheengatu-EPUB.css \
{} -f markdown -t epub -o {}.epub \;
