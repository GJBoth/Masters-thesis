PY=python
PANDOC=pandoc

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

BIBFILE=$(INPUTDIR)/references.bib

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make html                        generate a web version             '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make docx	                       generate a Docx file 			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '                                                                       '
	@echo ' 																	  '
	@echo ' 																	  '
	@echo 'get local templates with: pandoc -D latex/html/etc	  				  '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates		  '

pdf:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.pdf" \
	--template="$(STYLEDIR)/template.tex" \
	--bibliography="$(BIBFILE)" 2>pandoc.log \
	--csl="$(STYLEDIR)/nature.csl" \
	--highlight-style pygments \
	--top-level-division=chapter \
	--filter pandoc-crossref \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass=Dissertate \
	-N \
	--pdf-engine=xelatex \
	--verbose

tex:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.tex" \
	--bibliography="$(BIBFILE)" \
	-V fontsize=12pt \
	-V papersize=a4paper \
	-V documentclass=harvard-thesis \
	--top-level-division=chapter \
	-N \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--latex-engine=xelatex

docx:
	pandoc "$(INPUTDIR)"/*.md \
	-o "$(OUTPUTDIR)/thesis.docx" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/ref_format.csl" \
	--toc

html:
	rm -rf "$(INPUTDIR)"/html/
	mkdir "$(INPUTDIR)"/html/
	cp "$(INPUTDIR)"/*.md "$(INPUTDIR)"/html/

	sed -i "" "s/pdf/png/g" "$(INPUTDIR)"/html/*.md

	pandoc "$(INPUTDIR)"/html/*.md \
	-o "$(OUTPUTDIR)/thesis.html" \
	--standalone \
	--template="$(STYLEDIR)/template.html" \
	--bibliography="$(BIBFILE)" \
	--csl="$(STYLEDIR)/nature.csl" \
	--include-in-header="$(STYLEDIR)/style.css" \
	--top-level-division=chapter \
	--number-sections \
	--filter pandoc-crossref \
	--toc \
    --mathjax
	rm -rf "$(OUTPUTDIR)/source/figures"
	mkdir "$(OUTPUTDIR)/source/figures"
	cp -r "$(INPUTDIR)/figures/png" "$(OUTPUTDIR)/source/figures"
	rm -rf "$(INPUTDIR)"/html/
.PHONY: help pdf docx html tex
