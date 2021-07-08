# edit at https://thetimetube.herokuapp.com/gnuplotviewer/
set terminal svg enhanced size 3440,2160 font "Arial, 16" fontscale 1.1 background '#ffffff'

set size 1,1
set origin 0,0
set multiplot layout 3,2 columnsfirst title "Proposed Wilkinsburg/Pittsburgh Annexation Effect on Total Household Income and Property Tax for Wilkinsburg Residents" # scale 1.1,0.9


# https://alleghenycountytreasurer.us/real-estate-tax/
# 4.73 mills
allegheny_county_property_taxes(x) = x * (4.73/1000)

# https://www.wilkinsburgpa.gov/departments/finance-department/tax-questions/
wilkinsburg_income_taxes(x) = x * 0.01
# https://pittsburghpa.gov/finance/tax-descriptions
pittsburgh_city_earned_income_tax(x) = x * 0.01
pittsburgh_sd_earned_income_tax(x) = x * 0.02
pittsburgh_income_taxes(x) = pittsburgh_city_earned_income_tax(x) + pittsburgh_sd_earned_income_tax(x)

# https://alleghenycountytreasurer.us/real-estate-tax/local-and-school-district-tax-millage/
wilkinsburg_borough_property_taxes(x) = x * (14.00/1000)
wilkinsburg_school_property_taxes(x) = x * (26.5/1000)
wilkinsburg_total_property_taxes(x) = wilkinsburg_borough_property_taxes(x) + wilkinsburg_school_property_taxes(x)

pittsburgh_city_real_estate_tax(x) = x * (8.06/1000)
pittsburgh_school_property_taxes(x) = x * (9.95/1000)
pittsburgh_total_property_taxes(x) = pittsburgh_city_real_estate_tax(x) + pittsburgh_school_property_taxes(x)


wilkinsburg_taxes(income,property) = wilkinsburg_income_taxes(income) + wilkinsburg_total_property_taxes(property)

pittsburgh_taxes(income,property) = pittsburgh_income_taxes(income) + pittsburgh_total_property_taxes(property)

full_pct_change(income,property) = (pittsburgh_taxes(income,property) / wilkinsburg_taxes(income,property)) * 100
full_raw_change(income,property) = (pittsburgh_taxes(income,property) - wilkinsburg_taxes(income,property))

wsd_pittsburghre_taxes(income,property) = pittsburgh_city_earned_income_tax(income) + pittsburgh_city_real_estate_tax(property) + wilkinsburg_school_property_taxes(property)

no_sd_merger_pct_change(income,property) = (wsd_pittsburghre_taxes(income,property) / wilkinsburg_taxes(income,property)) * 100
no_sd_merger_raw_change(income,property) = (wsd_pittsburghre_taxes(income,property) - wilkinsburg_taxes(income,property))

sd_merger_only_taxes(income,property) = wilkinsburg_income_taxes(income) + pittsburgh_sd_earned_income_tax(income) +  pittsburgh_school_property_taxes(property) + wilkinsburg_borough_property_taxes(property)

sd_merger_only_pct_change(income,property) = (sd_merger_only_taxes(income,property) / wilkinsburg_taxes(income,property)) * 100
sd_merger_only_raw_change(income,property) = (sd_merger_only_taxes(income,property) - wilkinsburg_taxes(income,property))


set tic scale 0

#set palette rgbformula 30,31,32 #33,13,10
# line styles
set style line 1 lt 1 lc rgb '#5548c1' #
set style line 2 lt 1 lc rgb '#7982d7' #
set style line 3 lt 1 lc rgb '#abb8e7' #
set style line 4 lt 1 lc rgb '#dde3ef' #
set style line 5 lt 1 lc rgb '#ead3c6' #
set style line 6 lt 1 lc rgb '#dba188' #
set style line 7 lt 1 lc rgb '#ca6b55' #
set style line 8 lt 1 lc rgb '#b10027' #

# palette
set palette defined(\
40 '#5548c1',\
100 '#ffffff',\
250 '#b10027')

set cblabel "Percent Change in Total Taxes"
set format cb "%.1f%%"
set cbtics 10
set grid cbtics linewidth 3
#set cbrange [:250]
#unset cbtics

set termoption enhanced
save_encoding = GPVAL_ENCODING
set encoding utf8

#set key Left center top reverse
unset key

ei_low = 15000
ei_high = 300000
ei_tics = ei_low/3

pv_low = 0
pv_high = 190000
pv_tics = 20000

set decimal locale
set xlabel "Household Earned Income"
set xrange [ ei_low : ei_high ]
set format x "$%'.0f"
set xtics ei_tics rotate by 45
#set grid xtics

set yrange [ pv_low : pv_high ]
set ylabel "County-Assessed Property Value"
set format y "$%'.0f"
set ytics pv_tics
#set grid ytics

#set pm3d implicit at s
set pm3d at b

set title "Percentage Change of Total Taxes, Full Merger"

set isosamples (ei_high/ei_tics)*2,(pv_high/pv_tics)*4
set style fill solid 1 noborder

set view map

## INCOME LINES
# https://www.census.gov/quickfacts/fact/table/wilkinsburgboroughpennsylvania/PST045219
# https://censusreporter.org/profiles/16000US4285188-wilkinsburg-pa/
set arrow from 36743,pv_low to 36743,pv_high nohead front
set label "Median Household Income (2019) $36.7k" at 36743,-22000
set arrow from 50000,pv_low to 50000,pv_high nohead front
set label "65% of households are under $50k (2019)" at 50000,-28000

## PROPERTY TAX LINES

# first quartile
#set arrow from 0,9300 to 300000,9300 nohead front
#set label "1Q" at 0,9300
set label "(Renters)" at -11000,0
# median
set arrow from ei_low,26300 to ei_high,26300 nohead front
set label "Median $26.3k" at -10000,26300
# mean
set arrow from ei_low,41102.9 to ei_high,41102.9 nohead front
set label "Mean $41.1k" at -8000,45000 # collides with ytic
# third quartile
set arrow from ei_low,53750 to ei_high,53750 nohead front
set label "3Q $53.7k" at -7000,53750
# first stddev
set arrow from ei_low,90101.39 to ei_high,90101.39 nohead front
set label "1σ $90.1k" at -6000,90101.39
set arrow from ei_low,139101.1 to ei_high,139101.1 nohead front
set label "2σ $139k" at -8000,135101.1 # collides with ytic
set arrow from ei_low,188100.2 to ei_high,188100.2 nohead front
set label "3σ $188k" at -8000,188100.2

set label "Data sources: U.S. Census Bureau QuickFacts, Allegheny County via Western PA Regional Data Center" at -15000,-40000

splot full_pct_change(x,y), \
      '++' using (sprintf("%.2f", full_pct_change(x,y))) with labels

### PERCENT, NO SCHOOL

set title "Percent Change in Total Taxes, No School Merger"

set palette defined(\
GPVAL_Z_MIN '#5548c1',\
100 '#ffffff')#,\
#GPVAL_Z_MAX '#b10027')

splot no_sd_merger_pct_change(x,y), \
      '++' using (sprintf("%.2f", no_sd_merger_pct_change(x,y))) with labels

### Percent change, SD MERGER

set title "Percent Change in Total Taxes, School Merger Only"

set palette defined(\
GPVAL_Z_MIN '#5548c1',\
100 '#ffffff',\
250 '#b10027')

splot sd_merger_only_pct_change(x,y), \
      '++' using (sprintf("%.2f", sd_merger_only_pct_change(x,y))) with labels

### Raw Dollar Change, FULL MERGER

set title "Actual Dollar Change in Total Taxes, Full Merger"
set cblabel "Dollar Change in Total Taxes"
set format cb "$%'.0f"
set cbtics 240

set palette defined(\
-4560 '#5548c1',\
0 '#ffffff',\
5520 '#b10027')

splot full_raw_change(x,y), \
      '++' using (sprintf("%.2f", full_raw_change(x,y))) with labels

### RAW, NO SCHOOL

set title "Actual Dollar Change in Total Taxes, No School Merger"

set palette defined(\
GPVAL_Z_MIN '#5548c1',\
0 '#ffffff')#,\
#GPVAL_Z_MAX '#b10027')

splot no_sd_merger_raw_change(x,y), \
      '++' using (sprintf("%.2f", no_sd_merger_raw_change(x,y))) with labels

#splot '++' matrix using 1:2:(pct_change($1,$2)) with image, \
#      '++' matrix using 1:2:(sprintf("%g", pct_change($1,$2))) with labels

### RAW, school only

set title "Actual Dollar Change in Total Taxes, School Merger Only"
set palette defined(\
GPVAL_Z_MIN '#5548c1',\
0 '#ffffff',\
5760 '#b10027')

splot sd_merger_only_raw_change(x,y), \
      '++' using (sprintf("%.2f", sd_merger_only_raw_change(x,y))) with labels

unset multiplot
