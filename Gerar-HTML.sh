#!/bin/sh

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
