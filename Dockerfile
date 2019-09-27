# Sample usage:
#
# docker run --rm -v $(pwd):/work wsams/latex bash \
#   -c 'cd /work && pandoc -s resume.md -o resume.tex && \
#                   pdflatex resume.tex'
#
# Sample build command:
#
# docker build -t wsams/latex --pull .

FROM debian:bullseye

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get update && \
    apt-get install -y git \
                       vim \
                       wget \
                       curl \
                       zip \
                       unzip \
                       make \
                       pandoc \
                       pandoc-citeproc \
                       pandoc-sidenote \
                       python3-pygments \
                       fig2dev \
                       texlive \
                       texlive-fonts-recommended \
                       texlive-latex-recommended \
                       texlive-latex-extra && \
    apt-get clean -y

WORKDIR /work

