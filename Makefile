CHAPTERS = $(wildcard chapters/*.md)

EPUB_FILE = build/book.epub
MOBI_FILE = build/book.mobi


.PHONY: all
all: $(EPUB_FILE) $(MOBI_FILE)

.PHONY: clean
clean:
	rm -f build/*

$(EPUB_FILE): clean $(CHAPTERS) meta/title.txt meta/cover.jpg meta/stylesheet.css meta/metadata.xml
	pandoc \
		-o $(EPUB_FILE) \
		meta/title.txt \
		$(CHAPTERS) \
		--epub-cover-image=meta/cover.jpg \
		--epub-stylesheet=meta/stylesheet.css \
		--epub-metadata=meta/metadata.xml \
		--table-of-contents

$(MOBI_FILE): $(EPUB_FILE)
	kindlegen $(EPUB_FILE)
