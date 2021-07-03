# https://data.wprdc.org/dataset/property-assessments
ASSESSEMENTS_URL=https://data.wprdc.org/dataset/2b3df818-601e-4f06-b150-643557229491/resource/f2b8d575-e256-4718-94ad-1e12239ddb92/download/assessments.csv

MUNI_CODE ?= 866
CLASS_RESIDENCE = RESIDENTIAL

GNUPLOT_FILES = $(wildcard *.gnuplot)
TARGETS = $(GNUPLOT_FILES:gnuplot=svg) $(GNUPLOT_FILES:gnuplot=png)

ASSESSMENTS = assessments.csv
ASSESSMENTS_WILKINSBURG = wilkinsburg.csv
ASSESSMENTS_WILKINSBURG_RESIDENCES = wilkinsburg-residence.csv

XSV ?= xsv
ST ?= st
GNUPLOT ?= gnuplot
CURL ?=
INKSCAPE ?= flatpak run org.inkscape.Inkscape
PNGCRUSH ?= pngcrush

all: $(TARGETS) ## Create all artifacts

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

%.svg: %.gnuplot
	$(GNUPLOT) $< > $@

%.png: %.svg
	$(INKSCAPE) --export-filename=$@ --export-overwrite --export-type=png $<
	$(PNGCRUSH) -ow $@

debug: ## Print key variables
	@echo "GNUPLOT_FILES: $(GNUPLOT_FILES)"
	@echo "TARGETS: $(TARGETS)"

.PHONY: get-assessment-data
get-assessment-data: $(ASSESSMENTS) $(ASSESSMENTS_WILKINSBURG) $(ASSESSMENTS_WILKINSBURG_RESIDENCES) ## Retrieve and extract all assessment data

$(ASSESSMENTS): ## Download Allegheny County assessment data from WPRDC
	$(CURL) --output $@ "$(ASSESSMENTS_URL)"

%.csv.idx: %.csv
	$(XSV) index $< --output $@

$(ASSESSMENTS_WILKINSBURG): $(ASSESSMENTS) $(ASSESSMENTS).idx ## Extract Wilkinsburg data from county data
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep MUNICODE | cut -f 1 -d ' ') $(MUNI_CODE) $< > $@

$(ASSESSMENTS_WILKINSBURG_RESIDENCES): $(ASSESSMENTS_WILKINSBURG) $(ASSESSMENTS_WILKINSBURG).idx ## Extract residences only from Wilkinsburg data
	$(XSV) search --select $(shell xsv headers $(ASSESSMENTS) | grep CLASSDESC | cut -f 1 -d ' ') $(CLASS_RESIDENCE) $< > $@

.PHONY: stats-mean-stddev
stats-mean-stddev: $(ASSESSMENTS_WILKINSBURG_RESIDENCES) ## Use xsv to display stats
	$(XSV) stats $< | $(XSV) search --select 1 COUNTYTOTAL | $(XSV) select mean,stddev

.PHONY: stats-all
stats-all: wilkinsburg-residence.csv ## Use st to display many stats
	$(XSV) select COUNTYTOTAL $< | tail -n +2 | $(ST) --complete --transpose-output

# for those unaware, .phony is a meta-task that simply indicates that a task has no file output or that it should be run all of the time.
