#!/bin/bash

if [ -z $1 ]; then
    echo "This script accepts a Markdown document and produces a PDF document."
    echo "Usage: ./compile-resume <markdown document name without .md extension>"
    exit
fi

document=$1

trap "rm ${document}.aux ${document}.log ${document}.out ${document}.tex" 0

docker run --rm -v $(pwd):/work wsams/latex bash \
    -c "cd /work && \
        pandoc -s ${document}.md -o ${document}.tex && \
        pdflatex ${document}.tex"
