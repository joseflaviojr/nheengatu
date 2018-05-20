#!/bin/sh

find . -name "*.md" ! -name "README.md" -exec \
pandoc \
--standalone --template=Modelo/LaTeX.tex \
--filter pandoc-citeproc \
--atx-headers --number-sections \
--lua-filter=Extensao/Nheengatu.lua \
{} -f markdown -t latex -o {}.tex \;
