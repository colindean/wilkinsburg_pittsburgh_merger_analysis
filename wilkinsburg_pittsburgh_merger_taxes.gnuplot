# edit at https://thetimetube.herokuapp.com/gnuplotviewer/

set terminal svg enhanced size 1920,1080

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
set palette defined (\
0.000000  0.334791  0.283084  0.756495,\
0.032258  0.358463  0.329961  0.777134,\
0.064516  0.384197  0.375595  0.796252,\
0.096774  0.412066  0.420411  0.813918,\
0.129032  0.442119  0.464652  0.830208,\
0.161290  0.474392  0.508463  0.845204,\
0.193548  0.508911  0.551927  0.858994,\
0.225806  0.545690  0.595092  0.871671,\
0.258065  0.584740  0.637982  0.883336,\
0.290323  0.626066  0.680601  0.894092,\
0.322581  0.669670  0.722945  0.904050,\
0.354839  0.715549  0.764998  0.913324,\
0.387097  0.763702  0.806740  0.922035,\
0.419355  0.814122  0.848146  0.930308,\
0.451613  0.866801  0.889187  0.938272,\
0.483871  0.921729  0.929831  0.946064,\
0.516129  0.943107  0.925843  0.914369,\
0.548387  0.929415  0.877320  0.844886,\
0.580645  0.915786  0.828497  0.777697,\
0.612903  0.902058  0.779359  0.712904,\
0.645161  0.888093  0.729874  0.650600,\
0.677419  0.873772  0.679993  0.590875,\
0.709677  0.858993  0.629636  0.533813,\
0.741935  0.843670  0.578682  0.479498,\
0.774194  0.827730  0.526951  0.428010,\
0.806452  0.811110  0.474162  0.379431,\
0.838710  0.793759  0.419874  0.333847,\
0.870968  0.775631  0.363343  0.291350,\
0.903226  0.756686  0.303214  0.252045,\
0.935484  0.736891  0.236622  0.216053,\
0.967742  0.716213  0.155523  0.183513,\
1.000000  0.694626  0.002965  0.154582)
set cblabel "Percent Change in Total Taxes from Wilkinsburg to Pittsburgh"
set format cb "%.1f%%"
set cbtics 10
#set cbrange [:250]
#unset cbtics

set termoption enhanced
save_encoding = GPVAL_ENCODING
set encoding utf8

set title "Proposed Wilkinsburg/Pittsburgh Merger Effect on Total Income and Property Tax for Wilkinsburg Residents"
#set key Left center top reverse
unset key

set decimal locale
set xlabel "Earned Income Taxes"
set xrange [ 15000 : 250000 ]
set format x "$%'.0f"
set xtics 5000 rotate by 45
 
set yrange [ 20000 : 750000 ]
set ylabel "County-Assessed Property Value"
set format y "$%'.0f"
set ytics 20000

#set pm3d implicit at s
set pm3d at b


set isosamples 47,38
set style fill solid 1 noborder

set view map

splot pct_change(x,y), \
      '++' using (sprintf("%.2f", pct_change(x,y))) with labels

#splot '++' matrix using 1:2:(pct_change($1,$2)) with image, \
#      '++' matrix using 1:2:(sprintf("%g", pct_change($1,$2))) with labels

