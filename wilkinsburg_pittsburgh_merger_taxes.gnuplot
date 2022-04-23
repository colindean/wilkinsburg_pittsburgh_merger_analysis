# Copyright 2021 Colin Dean
# Some rights reserved. See LICENSE.md for details

set terminal svg enhanced size 3440,2160 font "Arial, 16" fontscale 1.1 background '#ffffff'

set size 1,1
set origin 0,0
set multiplot layout 2,2 columnsfirst title "Proposed Wilkinsburg/Pittsburgh Annexation Effect on Total Household Income and Property Tax for Wilkinsburg Residents" # scale 1.1,0.9


# https://alleghenycountytreasurer.us/real-estate-tax/
# 4.73 mills
allegheny_county_property_taxes(x) = x * (4.73/1000)

# https://www.wilkinsburgpa.gov/departments/finance-department/tax-questions/
wilkinsburg_borough_income_taxes(x) = x * 0.005
wilkinsburg_sd_income_taxes(x) = x * 0.005
wilkinsburg_income_taxes(x) = wilkinsburg_borough_income_taxes(x) + wilkinsburg_sd_income_taxes(x)

# https://pittsburghpa.gov/finance/tax-descriptions
pittsburgh_city_earned_income_tax(x) = x * 0.01
pittsburgh_sd_earned_income_tax(x) = x * 0.02
pittsburgh_income_taxes(x) = pittsburgh_city_earned_income_tax(x) + pittsburgh_sd_earned_income_tax(x)

# https://alleghenycountytreasurer.us/real-estate-tax/local-and-school-district-tax-millage/
wilkinsburg_borough_property_taxes(x) = x * (14.00/1000)
wilkinsburg_school_property_taxes(x) = x * (26.5/1000)
wilkinsburg_total_property_taxes(x) = wilkinsburg_borough_property_taxes(x) + wilkinsburg_school_property_taxes(x)
# https://pittsburghpa.gov/finance/tax-descriptions#476
pittsburgh_city_real_estate_tax_parks(x) = x * (0.50/1000)
# https://pittsburghpa.gov/finance/tax-descriptions#36
pittsburgh_city_real_estate_tax_library(x) = x * (0.25/1000)
# https://pittsburghpa.gov/finance/tax-descriptions#29
pittsburgh_city_real_estate_tax_ret(x) = x * (8.06/1000)
pittsburgh_city_real_estate_tax(x) = pittsburgh_city_real_estate_tax_ret(x) + pittsburgh_city_real_estate_tax_parks(x) + pittsburgh_city_real_estate_tax_library(x)
pittsburgh_school_property_taxes(x) = x * (10.25/1000)
pittsburgh_total_property_taxes(x) = pittsburgh_city_real_estate_tax(x) + pittsburgh_school_property_taxes(x)


wilkinsburg_taxes(income,property) = wilkinsburg_income_taxes(income) + wilkinsburg_total_property_taxes(property)

pittsburgh_taxes(income,property) = pittsburgh_income_taxes(income) + pittsburgh_total_property_taxes(property)

full_pct_change(income,property) = (pittsburgh_taxes(income,property) / wilkinsburg_taxes(income,property)) * 100
full_raw_change(income,property) = (pittsburgh_taxes(income,property) - wilkinsburg_taxes(income,property))

wsd_pittsburghre_taxes(income,property) = pittsburgh_city_earned_income_tax(income) + \
                                          pittsburgh_city_real_estate_tax(property) + \
                                          wilkinsburg_school_property_taxes(property) + \
                                          wilkinsburg_sd_income_taxes(income)

sd_merger_only_taxes(income,property) = wilkinsburg_borough_income_taxes(income) + \
                                        wilkinsburg_borough_property_taxes(property) + \
                                        pittsburgh_sd_earned_income_tax(income) + \
                                        pittsburgh_school_property_taxes(property)

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
50 '#5548c1',\
100 '#ffffff',\
310.0 '#b10027')

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
pv_high = 220000
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
ei_med = 37649.0
ei_62pct = 50000.0
ei_stat_year = 2020
set arrow from ei_med,pv_low to ei_med,pv_high nohead front
set label sprintf("Median Household Income $%'.1fk (%0.0f)", ei_med/1000, ei_stat_year) at ei_med,-28500
set arrow from ei_62pct,pv_low to ei_62pct,pv_high nohead front
set label sprintf("62%% of households are under $%'.0fk (%0.0f)", ei_62pct/1000, ei_stat_year) at ei_62pct,-33000

## PROPERTY TAX LINES

# output of `make stats-all-liveable`
pv_1q = 17200.0
pv_med = 33200.0
pv_3q = 62800.0
pv_mean = 49446.5
pv_stddev = 52509.0

nth_pv_stddev(x) = pv_mean + (pv_stddev * x)

# first quartile
set arrow from ei_low,pv_1q to ei_high,pv_1q nohead front
set label sprintf("1Q $%'0.1fk", pv_1q / 1000) at -3000,(pv_1q-4000) # collides with ytic
set label "(Renters)" at -16000,0
# median
set arrow from ei_low,pv_med to ei_high,pv_med nohead front
set label sprintf("Median $%'0.1fk", pv_med / 1000) at -10000,pv_med
# mean
set arrow from ei_low,pv_mean to ei_high,pv_mean nohead front
set label sprintf("Mean $%'0.1fk", pv_mean / 1000) at -7000,(pv_mean + 4000) # collides with ytic
# third quartile
set arrow from ei_low,pv_3q to ei_high,pv_3q nohead front
set label sprintf("3Q $%'0.1fk", pv_3q / 1000) at -3000,(pv_3q+4000) # collides with ytic
# first stddev
set arrow from ei_low,nth_pv_stddev(1) to ei_high,nth_pv_stddev(1) nohead front
set label sprintf("1σ $%'0.1fk", nth_pv_stddev(1)/1000) at -4000,(nth_pv_stddev(1)+2000) # collides with ytic
set arrow from ei_low,nth_pv_stddev(2) to ei_high,nth_pv_stddev(2) nohead front
set label sprintf("2σ $%'0.1fk", nth_pv_stddev(2)/1000) at -4000,(nth_pv_stddev(2)-2000) # collides with ytic
set arrow from ei_low,nth_pv_stddev(3) to ei_high,nth_pv_stddev(3) nohead front
set label sprintf("3σ $%'0.1fk", nth_pv_stddev(3)/1000) at -4000,(nth_pv_stddev(3)-1000)

set label "Data sources: U.S. Census Bureau, Allegheny County via Western PA Regional Data Center" at -15000,-40000
set label "Assessment statistics include only parcels that are residential with buildings that are not condemned." at -15000,-46000

splot full_pct_change(x,y)#, \
      #'++' using (sprintf("%.2f", full_pct_change(x,y))) with labels

### Percent change, SD MERGER

set title "Percent Change in Total Taxes, School Merger Only"

set palette defined(\
60.0 '#5548c1',\
100.0 '#ffffff',\
260.0 '#b10027')

splot sd_merger_only_pct_change(x,y)#, \
      #'++' using (sprintf("%.2f", sd_merger_only_pct_change(x,y))) with labels

### Raw Dollar Change, FULL MERGER

set title "Actual Dollar Change in Total Taxes, Full Merger"
set cblabel "Dollar Change in Total Taxes"
set format cb "$%'.0f"
set cbtics 240

set palette defined(\
-4080.0 '#5548c1',\
0 '#ffffff',\
6000.0 '#b10027')

splot full_raw_change(x,y)#, \
      #'++' using (sprintf("%.2f", full_raw_change(x,y))) with labels

### RAW, school only

set title "Actual Dollar Change in Total Taxes, School Merger Only"
set palette defined(\
-3120.0 '#5548c1',\
0.0 '#ffffff',\
4560.0 '#b10027')

splot sd_merger_only_raw_change(x,y)#, \
      #'++' using (sprintf("%.2f", sd_merger_only_raw_change(x,y))) with labels

unset multiplot
