PAGES = index.html chuckie.html pork-rub.html board-sauce.html jalapeno-relish.html salsa-verde.html
HOST = recipes.eatabrick.org
PATH = /usr/local/www/$(HOST)
TEMPLATES = template/header.tt template/footer.tt

TPAGE = tpage
MARKDOWN = markdown
SCP = scp

.PHONY: all deploy clean

all: $(PAGES)

deploy: all
	$(SCP) $(PAGES) www/* $(HOST):$(PATH)/.

clean:
	rm $(PAGES)

index.html: index.tt $(TEMPLATES)
	$(TPAGE) template/header.tt > $(.TARGET)
	$(TPAGE) index.tt | $(MARKDOWN) >> $(.TARGET)
	$(TPAGE) template/footer.tt >> $(.TARGET)

.SUFFIXES: .html .md
.md.html: $(TEMPLATES)
	$(TPAGE) --define title=$(.PREFIX) template/header.tt > $(.TARGET)
	$(MARKDOWN) $(.IMPSRC) >> $(.TARGET)
	$(TPAGE) template/footer.tt >> $(.TARGET)
