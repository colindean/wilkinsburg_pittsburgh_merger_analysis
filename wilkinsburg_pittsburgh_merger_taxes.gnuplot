# edit at https://thetimetube.herokuapp.com/gnuplotviewer/
set terminal svg enhanced size 1920,2160

set size 1,1
set origin 0,0
set multiplot layout 2,1 columnsfirst title "Proposed Wilkinsburg/Pittsburgh Merger Effect on Total Income and Property Tax for Wilkinsburg Residents" # scale 1.1,0.9


# https://alleghenycountytreasurer.us/real-estate-tax/
# 4.73 mills
allegheny_county_property_taxes(x) = x * (4.73/1000)

#
wilkinsburg_income_taxes(x) = x * 0.01
pittsburgh_income_taxes(x) = x * 0.03

# https://alleghenycountytreasurer.us/real-estate-tax/local-and-school-district-tax-millage/
wilkinsburg_borough_property_taxes(x) = x * (14.00/1000)
wilkinsburg_school_property_taxes(x) = x * (29.5/1000)
wilkinsburg_total_property_taxes(x) = wilkinsburg_borough_property_taxes(x) + wilkinsburg_school_property_taxes(x)

pittsburgh_borough_property_taxes(x) = x * (8.06/1000)
pittsburgh_school_property_taxes(x) = x * (9.95/1000)
pittsburgh_total_property_taxes(x) = pittsburgh_borough_property_taxes(x) + pittsburgh_school_property_taxes(x)


wilkinsburg_taxes(income,property) = wilkinsburg_income_taxes(income) + wilkinsburg_total_property_taxes(property)

pittsburgh_taxes(income,property) = pittsburgh_income_taxes(income) + pittsburgh_total_property_taxes(property)

pct_change(income,property) = (pittsburgh_taxes(income,property) / wilkinsburg_taxes(income,property)) * 100

raw_change(income,property) = (pittsburgh_taxes(income,property) - wilkinsburg_taxes(income,property))

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

set cblabel "Percent Change in Total Taxes from Wilkinsburg to Pittsburgh"
set format cb "%.1f%%"
set cbtics 10
#set cbrange [:250]
#unset cbtics

set termoption enhanced
save_encoding = GPVAL_ENCODING
set encoding utf8

#set key Left center top reverse
unset key

set decimal locale
set xlabel "Earned Income Taxes"
set xrange [ 15000 : 300000 ]
set format x "$%'.0f"
set xtics 5000 rotate by 45

set yrange [ 20000 : 190000 ]
set ylabel "County-Assessed Property Value"
set format y "$%'.0f"
set ytics 20000

#set pm3d implicit at s
set pm3d at b

set title "Percentage change"

set isosamples 47,38
set style fill solid 1 noborder

set view map

# first quartile
#set arrow from 0,9300 to 300000,9300 nohead front
#set label "1Q" at 0,9300
# median
set arrow from 15000,26300 to 300000,26300 nohead front
set label "Median $26.3k" at 0,26300
# mean
set arrow from 15000,41102.9 to 300000,41102.9 nohead front
set label "Mean $41.1k" at 0,43000 # collides with ytic
# third quartile
set arrow from 15000,53750 to 300000,53750 nohead front
set label "3Q $53.7k" at 0,53750
# first stddev
set arrow from 15000,90101.39 to 300000,90101.39 nohead front
set label "1σ $90.1k" at 0,90101.39

splot pct_change(x,y), \
      '++' using (sprintf("%.2f", pct_change(x,y))) with labels

### Raw Dollar Change

set title "Actual Dollar Change in Total Taxes"
set cblabel "Dollar Change in Total Taxes"
set format cb "$%'.0f"
set cbtics 240

set palette defined(\
-4560 '#5548c1',\
0 '#ffffff',\
5520 '#b10027')

splot raw_change(x,y), \
      '++' using (sprintf("%.2f", raw_change(x,y))) with labels

#splot '++' matrix using 1:2:(pct_change($1,$2)) with image, \
#      '++' matrix using 1:2:(sprintf("%g", pct_change($1,$2))) with labels

unset multiplot
