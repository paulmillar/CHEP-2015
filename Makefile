
SRC=dCache-CDMI-CHEP2015.tex dCache-cloud-CHEP2015.tex LSDMA-CHEP2015.tex

TARGET=$(SRC:%.tex=%.pdf)

GENERATED=$(SRC:%.tex=%.log) $(SRC:%.tex=%.aux) ${SRC:%=%~} $(SRC:%.tex=%.bbl) $(SRC:%.tex=%.blg)


#  Source of SVG figures.
FIGS_SRC=Figures/dCache-cloud.svg
#FIGS_SRC=Figures/atlas-pilots.svg Figures/atlas-production.svg Figures/cms-overall.svg Figures/atlas-overall.svg Figures/cms-production.svg Figures/cms-analysis.svg Figures/cms-users-selected-1.svg Figures/cms-users-selected-2.svg Figures/protocol-usage-1.svg

FIGS_PDF=$(FIGS_SRC:%.svg=%.pdf)

all: ${FIGS_PDF} ${TARGET}

%.pdf: %.tex %.bbl
	pdflatex $<
	pdflatex $<

%.aux: %.tex
	pdflatex $<

%.bbl: %.bib %.aux
	bibtex $(<:%.bib=%)

%.pdf: %.svg
	inkscape --export-pdf=$@ $<

view: ${TARGET}
	okular ${TARGET}

clean:
	rm -f ${TARGET} ${GENERATED}

.PRECIOUS: $(SRC:%.tex=%.bbl) ${FIGS_PDF}
