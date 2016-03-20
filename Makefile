LANGS=en
TARGETS=$(addprefix YunfengWang_,$(LANGS))
PDF_TARGETS=$(addsuffix .pdf,$(TARGETS))
HTML_TARGETS=$(addsuffix .html,$(TARGETS))

all: pdf html

pdf: $(PDF_TARGETS)

html: $(HTML_TARGETS)

gh-pages: html
	mv $(HTML_TARGETS) /tmp
	git checkout gh-pages
	cd /tmp && mv $(HTML_TARGETS) $(CURDIR)
	git commit -a -m "Regenerate gh-pages"
	git push
	git checkout master

englishcv: RaphaelPinson_en.pdf

%.pdf: %.tex
	xelatex -interaction=batchmode $<
	xelatex -interaction=batchmode $<

%.html: %.pdf
	pdf2htmlEX --zoom=2 $<

clean:
	rm -f *.aux *.log *.out

