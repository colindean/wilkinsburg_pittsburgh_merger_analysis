ASSESSEMENTS_URL=https://data.wprdc.org/dataset/2b3df818-601e-4f06-b150-643557229491/resource/f2b8d575-e256-4718-94ad-1e12239ddb92/download/assessments.csv

MUNI_CODE ?= 866
CLASS_RESIDENCE = RESIDENTIAL

FILES = $(wildcard *.gnuplot)
TARGETS = $(FILES:gnuplot=svg) $(FILES:gnuplot=png)

ASSESSMENTS = assessments.csv

XSV ?= xsv
INKSCAPE ?= flatpak run org.inkscape.Inkscape

all: $(TARGETS)

%.svg: %.gnuplot
	gnuplot $< > $@

%.png: %.svg
	$(INKSCAPE) --export-filename=$@ --export-overwrite --export-type=png $<

debug:
	@echo "FILES: $(FILES)"
	@echo "TARGETS: $(TARGETS)"

.PHONY: get-county-data
get-county-data: $(ASSESSMENTS)

$(ASSESSMENTS):
	curl --output $@ "$(ASSESSMENTS_URL)"

%.csv.idx: %.csv
	$(XSV) index $< --output $@

wilkinsburg.csv: assessments.csv assessments.csv.idx
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep MUNICODE | cut -f 1 -d ' ') $(MUNI_CODE) $< > $@

wilkinsburg-residence.csv: wilkinsburg.csv wilkinsburg.csv.idx
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep CLASSDESC | cut -f 1 -d ' ') $(CLASS_RESIDENCE) $< > $@

mean-stddev: wilkinsburg-residence.csv
	$(XSV) stats $< | $(XSV) search --select 1 COUNTYTOTAL | xsv select mean,stddev
