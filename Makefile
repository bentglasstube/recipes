SOURCES=$(wildcard *.md)
PAGES=index.html $(patsubst %.md,%.html,$(SOURCES))
HOST=recipes.eatabrick.org
RPATH=/usr/local/www/$(HOST)
TEMPLATES=template/header.tt template/footer.tt

TPAGE=tpage
MARKDOWN=markdown
SCP=scp

.PHONY: all deploy clean

all: $(PAGES)

deploy: all
	$(SCP) $(PAGES) www/* $(HOST):$(RPATH)/.

clean:
	rm $(PAGES)

index.html: index.tt $(TEMPLATES)
	$(TPAGE) template/header.tt > $@
	$(TPAGE) index.tt | $(MARKDOWN) >> $@
	$(TPAGE) template/footer.tt >> $@

.SUFFIXES: .html .md
.md.html: $(TEMPLATES)
	$(TPAGE) --define title=$* template/header.tt > $@
	$(MARKDOWN) $_ >> $@
	$(TPAGE) template/footer.tt >> $@
