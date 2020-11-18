MARKDOWN_FILES := $(shell find . -type f | grep .md)
HTML_FILES=$(patsubst %.md,%.html,$(MARKDOWN_FILES))

all: docs

docs: $(HTML_FILES)

$(HTML_FILES) : $(MARKDOWN_FILES) .PHONY
	@echo $(@:.html=.md)
	@markdown $(@:.html=.md) > $@

.PHONY: