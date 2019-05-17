PAGES = index.html chuckie.html
HOST = recipes.eatabrick.org
PATH = /usr/local/www/$(HOST)

TPAGE = tpage
MARKDOWN = markdown
SCP = scp

.PHONY: all deploy clean

all: $(PAGES)

deploy: all
	$(SCP) $(PAGES) www/* $(HOST):$(PATH)/.

clean:
	rm $(PAGES)

.SUFFIXES: .html .md
.md.html: template/footer.tt template/header.tt
	$(TPAGE) --define title=$(.PREFIX) template/header.tt > $(.TARGET)
	$(MARKDOWN) $(.IMPSRC) >> $(.TARGET)
	$(TPAGE) template/footer.tt >> $(.TARGET)
