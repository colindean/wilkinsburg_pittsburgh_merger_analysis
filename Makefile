ASSESSEMENTS_URL=https://data.wprdc.org/dataset/2b3df818-601e-4f06-b150-643557229491/resource/f2b8d575-e256-4718-94ad-1e12239ddb92/download/assessments.csv

MUNI_CODE ?= 866
CLASS_RESIDENCE = RESIDENTIAL

FILES = $(wildcard *.gnuplot)
TARGETS = $(FILES:gnuplot=svg) $(FILES:gnuplot=png)

ASSESSMENTS = assessments.csv

XSV ?= xsv
ST ?= st
GNUPLOT ?= gnuplot
CURL ?=
INKSCAPE ?= flatpak run org.inkscape.Inkscape

all: $(TARGETS) ## Create all artifacts

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

%.svg: %.gnuplot
	$(GNUPLOT) $< > $@

%.png: %.svg
	$(INKSCAPE) --export-filename=$@ --export-overwrite --export-type=png $<

debug: ## Print key variables
	@echo "FILES: $(FILES)"
	@echo "TARGETS: $(TARGETS)"

.PHONY: get-county-data
get-county-data: $(ASSESSMENTS)

$(ASSESSMENTS):
	$(CURL) --output $@ "$(ASSESSMENTS_URL)"

%.csv.idx: %.csv
	$(XSV) index $< --output $@

wilkinsburg.csv: assessments.csv assessments.csv.idx
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep MUNICODE | cut -f 1 -d ' ') $(MUNI_CODE) $< > $@

wilkinsburg-residence.csv: wilkinsburg.csv wilkinsburg.csv.idx
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep CLASSDESC | cut -f 1 -d ' ') $(CLASS_RESIDENCE) $< > $@

stats-mean-stddev: wilkinsburg-residence.csv ## Use xsv to display stats
	$(XSV) stats $< | $(XSV) search --select 1 COUNTYTOTAL | $(XSV) select mean,stddev

stats-all: wilkinsburg-residence.csv ## Use st to display many stats
	$(XSV) select COUNTYTOTAL $< | tail -n +2 | $(ST) --complete --transpose-output

