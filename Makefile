img.png: img.pnm
	pnmtopng $< > $@

img.pnm: grayscott.dyalog
	dyalog -nokbd -script $<
