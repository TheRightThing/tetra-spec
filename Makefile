MARKDOWN_FILES := $(shell find . -type f | grep .md)
HTML_FILES=$(patsubst %.md,%.html,$(MARKDOWN_FILES))

all: spec docs
clean: spec_clean docs_clean

docs: $(HTML_FILES)

$(HTML_FILES) : $(MARKDOWN_FILES) .PHONY
	@echo $(@:.html=.md)
	@markdown $(@:.html=.md) > $@

docs_clean: .PHONY
	rm -f $(HTML_FILES)

SPEC_SRC=tetra-spec
spec: .PHONY
	pdflatex latex/$(SPEC_SRC)
	# bibtex   $(SPEC_SRC)
	pdflatex latex/$(SPEC_SRC)
	pdflatex latex/$(SPEC_SRC)

spec_clean:
	rm -f *~ $(SPEC_SRC).{pdf,log,aux,bbl,blg,toc,out}

.PHONY: