# Sample usage:
#
# docker run --rm -v $(pwd):/work wsams/latex bash \
#   -c 'cd /work && pandoc -s resume.md -o resume.tex && \
#                   pdflatex resume.tex'
#
# Sample build command:
#
# docker build -t wsams/latex --pull .
#
# siamtex compatibility: this image ships latexmk, biber, xelatex, and lualatex
# so it can serve as the base for the siamtex tex-worker.  The non-root texuser
# (uid/gid 10001) matches the uid used by the siamtex docker-compose sandbox.

FROM debian:bookworm

ENV DEBIAN_FRONTEND=noninteractive

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
                       git \
                       vim \
                       wget \
                       curl \
                       zip \
                       unzip \
                       make \
                       pandoc \
                       pandoc-sidenote \
                       python3-pygments \
                       fig2dev \
                       latexmk \
                       biber \
                       texlive \
                       texlive-fonts-recommended \
                       texlive-latex-recommended \
                       texlive-latex-extra \
                       texlive-xetex \
                       texlive-luatex \
                       texlive-science \
                       texlive-publishers && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Create a non-root user (uid 10001) that matches the siamtex sandbox uid so
# this image can be used directly as the siamtex tex-worker base image.
RUN useradd --create-home --uid 10001 --shell /usr/sbin/nologin texuser && \
    mkdir -p /work && \
    chown texuser:texuser /work

WORKDIR /work

