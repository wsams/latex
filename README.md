# wsams/latex \LaTeX  environment

This image provides a consistent \LaTeX environment built on **Debian Bookworm**.  It
also includes `pandoc` for converting documents between formats.  A nightly GitHub
Actions workflow builds the image and pushes it to Harbor automatically.

## Quick start

```
./compile-document.sh README
```

This produces a `README.pdf` using the following Docker command:

```
docker run --rm -v $(pwd):/work wsams/latex bash \
    -c "cd /work && \
        pandoc -s README.md -o README.tex && \
        pdflatex README.tex"
```

Convert an existing `.tex` file to PDF:

```
docker run --rm -v $(pwd):/work wsams/latex bash \
    -c "cd /work && pdflatex resume.tex"
```

## Included engines and tools

| Tool | Purpose |
|---|---|
| `pdflatex` | Standard PDF output |
| `xelatex` | Unicode / system-font support |
| `lualatex` | Lua-scriptable PDF output |
| `bibtex` / `biber` | Bibliography processing |
| `latexmk` | Automated multi-pass compilation |
| `pandoc` | Markdown → LaTeX / PDF conversion (citeproc built-in) |

## siamtex compatibility

The image ships a non-root `texuser` account (uid/gid **10001**) that matches the
sandbox uid used by [wsams/siamtex](https://github.com/wsams/siamtex).  The
`docker/tex-worker/Dockerfile` in that project can reference this Harbor image as
its base instead of `texlive/texlive:latest-small`:

```dockerfile
FROM <HARBOR_REGISTRY>/latex:latest

WORKDIR /work
USER texuser
ENTRYPOINT ["latexmk"]
CMD ["-pdf", "-interaction=nonstopmode", "-halt-on-error", "main.tex"]
```

Set `SIAMTEX_DOCKER_IMAGE` in siamtex's `.env` to the Harbor image tag.

## Nightly CI / Harbor push

The workflow `.github/workflows/nightly.yml` runs every night at 02:00 UTC (and on
every push to `main`).  It requires four repository secrets:

| Secret | Description |
|---|---|
| `HARBOR_HOST` | Registry hostname only, e.g. `harbor.example.com` |
| `HARBOR_PROJECT` | Project path within Harbor, e.g. `wsams` |
| `HARBOR_USERNAME` | Harbor robot-account name or user name |
| `HARBOR_PASSWORD` | Harbor robot-account secret or password |

The image is pushed as `$HARBOR_HOST/$HARBOR_PROJECT/latex` with three tags: `latest`,
`YYYY-MM-DD`, and a short git SHA.

## Available texlive packages (Debian Bookworm)

```
These are all of the packages available in debian:bookworm

texlive - TeX Live: A decent selection of the TeX Live packages
texlive-base - TeX Live: Essential programs and files
texlive-fonts-recommended - TeX Live: Recommended fonts
texlive-fonts-recommended-doc - TeX Live: Documentation files for texlive-fonts-recommended
texlive-full - TeX Live: metapackage pulling in all components of TeX Live
texlive-latex-base - TeX Live: LaTeX fundamental packages
texlive-latex-base-doc - TeX Live: Documentation files for texlive-latex-base
texlive-latex-recommended - TeX Live: LaTeX recommended packages
texlive-latex-recommended-doc - TeX Live: Documentation files for texlive-latex-recommended
texlive-luatex - TeX Live: LuaTeX packages
texlive-metapost - TeX Live: MetaPost and Metafont packages
texlive-metapost-doc - TeX Live: Documentation files for texlive-metapost
texlive-pictures - TeX Live: Graphics, pictures, diagrams
texlive-pictures-doc - TeX Live: Documentation files for texlive-pictures
texlive-xetex - TeX Live: XeTeX and packages
texlive-binaries - Binaries for TeX Live
texlive-bibtex-extra - TeX Live: BibTeX additional styles
texlive-extra-utils - TeX Live: TeX auxiliary programs
texlive-font-utils - TeX Live: Graphics and font utilities
texlive-fonts-extra - TeX Live: Additional fonts
texlive-fonts-extra-doc - TeX Live: Documentation files for texlive-fonts-extra
texlive-fonts-extra-links - TeX Live:
texlive-formats-extra - TeX Live: Additional formats
texlive-games - TeX Live: Games typesetting
texlive-humanities - TeX Live: Humanities packages
texlive-humanities-doc - TeX Live: Documentation files for texlive-humanities
texlive-latex-extra - TeX Live: LaTeX additional packages
texlive-latex-extra-doc - TeX Live: Documentation files for texlive-latex-extra
texlive-music - TeX Live: Music packages
texlive-plain-generic - TeX Live: Plain (La)TeX packages
texlive-pstricks - TeX Live: PSTricks
texlive-pstricks-doc - TeX Live: Documentation files for texlive-pstricks
texlive-publishers - TeX Live: Publisher styles, theses, etc.
texlive-publishers-doc - TeX Live: Documentation files for texlive-publishers
texlive-science - TeX Live: Mathematics, natural sciences, computer science packages
texlive-science-doc - TeX Live: Documentation files for texlive-science
texlive-lang-all - TeX Live: metapackage depending on all TeX Live language packages
texlive-lang-arabic - TeX Live: Arabic
texlive-lang-chinese - TeX Live: Chinese
texlive-lang-cjk - TeX Live: Chinese/Japanese/Korean (base)
texlive-lang-cyrillic - TeX Live: Cyrillic
texlive-lang-czechslovak - TeX Live: Czech/Slovak
texlive-lang-english - TeX Live: US and UK English
texlive-lang-european - TeX Live: Other European languages
texlive-lang-french - TeX Live: French
texlive-lang-german - TeX Live: German
texlive-lang-greek - TeX Live: Greek
texlive-lang-italian - TeX Live: Italian
texlive-lang-japanese - TeX Live: Japanese
texlive-lang-korean - TeX Live: Korean
texlive-lang-other - TeX Live: Other languages
texlive-lang-polish - TeX Live: Polish
texlive-lang-portuguese - TeX Live: Portuguese
texlive-lang-spanish - TeX Live: Spanish
```

Create your own `Dockerfile` with the following contents. In this example we'll install the `texlive-music` package.

```dockerfile
FROM <HARBOR_REGISTRY>/latex:latest

RUN apt-get update && \
    apt-get install -y --no-install-recommends texlive-music && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*
```

Now build your image,

```
docker build -t music-latex --pull .
```

Once your new `music-latex` image is built you can [begin creating beautiful sheetmusic](https://packages.debian.org/sid/texlive-music). The commands will be similar to the previous examples.

Have fun!

