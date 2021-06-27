ASSESSEMENTS_URL=https://data.wprdc.org/dataset/2b3df818-601e-4f06-b150-643557229491/resource/f2b8d575-e256-4718-94ad-1e12239ddb92/download/assessments.csv

MUNI_CODE ?= 866
CLASS_RESIDENCE = RESIDENTIAL

FILES = $(wildcard *.gnuplot)
TARGETS = $(FILES:gnuplot=svg)

ASSESSMENTS = assessments.csv

all: $(TARGETS)

%.svg: %.gnuplot
	gnuplot $< > $@

debug:
	@echo "FILES: $(FILES)"
	@echo "TARGETS: $(TARGETS)"

.PHONY: get-county-data
get-county-data: $(ASSESSMENTS)

$(ASSESSMENTS):
	curl --output $@ "$(ASSESSMENTS_URL)"

%.csv.idx: %.csv
	xsv index $< --output $@

wilkinsburg.csv: assessments.csv assessments.csv.idx
	xsv search --select $(shell xsv headers $(ASSESSMENTS) | grep MUNICODE | cut -f 1 -d ' ') $(MUNI_CODE) $< > $@

wilkinsburg-residence.csv: wilkinsburg.csv wilkinsburg.csv.idx
	xsv search --select $(shell xsv headers $(ASSESSMENTS) | grep CLASSDESC | cut -f 1 -d ' ') $(CLASS_RESIDENCE) $< > $@

mean-stddev: wilkinsburg-residence.csv
	xsv stats $< | xsv search --select 1 COUNTYTOTAL | xsv select mean,stddev
