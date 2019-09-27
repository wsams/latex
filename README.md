# wsams/latex \LaTeX  environment

This image was created to provide a consistent \LaTeX environment. It also provides the `pandoc` tool for converting documents into various types. For example, this `README.md` document can be converted into \LaTeX  and then further a PDF document. Give it a try,

```
./compile-document.sh README
```

The command above should produce a `README.pdf`. The script is just running the following Docker command,

```
docker run --rm -v $(pwd):/work wsams/latex bash \
    -c "cd /work && \
        pandoc -s README.md -o README.tex && \
        pdflatex README.tex"
```

If you just want to convert a `resume.tex` document into a PDF using `pdflatex` you can run the following,

```
docker run --rm -v $(pwd):/work wsams/latex bash \
    -c "cd /work && pdflatex resume.tex"
```

Of course you can do anything possible with the `texlive` packages. Below is a list currently available in `debian:bullseye`. Below the list is an example if you want to build your own custom image.

```
These are all of the packages available in debian:bullseye

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

```
FROM wsams/latex

RUN apt-get update && \
    apt-get install -y texlive-music && \
    apt-get clean -y
```

Now build your image,

```
docker build -t music-latex --pull .
```

Once your new `music-latex` image is built you can [begin creating beautiful sheetmusic](https://packages.debian.org/sid/texlive-music). The commands will be similar to the previous examples.

Have fun!

