# Custom Bibliographic Style File Process

## Introduction

A Bibliographic STyle file (.bst) tells BibTeX how to style the entries found in a bibliography file
(.bib) as used in producing a LaTeX typeset document.

> Note that this is largely untested due to this repository switching to BibLaTeX, archived here in
> case this information might be of some future use.

The steps that need to be followed to generate a .bst file are outlined below. Note that it is possible to jump in at any step using the files in this folder, one does
not necessarily need to repeat all steps to change the outcome.

## Step 1

From the command line run:

```bash
$ mkdir new
$ cd new
$ latex makebst
```

This will ask a long list of questions. The first of which is which Master  Bibliography Style to use (default=merlin.mbs). The .mbs files may be part of the LaTeX installation and can be found at locations like:

```bash
/usr/share/texlive/texmf-dist/tex/latex/custom-bib/merlin.mbs
```

As promised in merlin.mbs, the file is a valid LaTeX file and self-documenting. So, optionally, copying it to a temp directory and LaTeXing it should produce a pdf or dvi file which can be viewed, for example:

```bash
$ mkdir temp
$ cd temp
$ cp /usr/share/texlive/texmf-dist/tex/latex/custom-bib/merlin.mbs .
$ latex merlin.mbs
$ okular merlin.dvi
```

Read the above file more more details.

## Step 2

Following a successful run of `latex makebst` there should be two or three files produced: a log of the run (makebst.log) and the batch file (agps.dbj). Assuming one didn't rush past the last question and answered 'y' to running the 'batch job' then there should also be present the final style file (agps.bst).

The .dbj file is now the source file with comments, and `docstrip` has been used to strip the comments to produce the smaller .bst file.

## Step 2a

Should one wish to modify the style further, it is possible to edit the source batch file (agps.dbj) and then simply LaTeX it to update the style file (agps.bst):

```bash
$ latex agps.dbj
```

This is achieved since the batch file contains `\input docstrip` to incite `docstrip` to do it's work.

## Step 3

Using the custom style file in a LaTeX preamble, for example in document.tex:

```
\bibliographystyle{agps}
```

The agps.bst file must, of course, be copied to the same directory as document.tex or be otherwise referenced or made accessible to LaTeX/BibTeX.