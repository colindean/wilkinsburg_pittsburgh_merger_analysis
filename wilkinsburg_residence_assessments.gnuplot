set terminal svg enhanced size 3440,2160 font "Arial, 16" fontscale 1.1 background '#ffffff'

set key off
set border 3

set title "Frequency chart of Wilkinsburg residential property assessments"

# Add a vertical dotted line at x=0 to show centre (mean) of distribution.
set yzeroaxis


bin_width = 10000

# Each bar is half the (visual) width of its x-range.
set boxwidth (bin_width/2) absolute
set style fill solid 1.0 noborder

set decimal locale
set xlabel "Allegheny County Total Property Assessment" offset 0,-2
set format x "$%'2.0f"
set xtics bin_width rotate by 45 offset 0,-2

set ylabel "Frequency (Count)"
set ytics 25


bin_number(x) = floor(x/bin_width)

rounded(x) = bin_width * ( bin_number(x) + 0.5 )

set datafile separator ','

set label sprintf("Bin width = $%'.0f", bin_width) at 0,-75

# first quartile
#set arrow from 0,9300 to 300000,9300 nohead front
#set label "1Q" at 0,9300
# median
set arrow from 26300,0 to 26300,1675 nohead front
set label "Median $26.3k" at 26300,1000 front
# mean
set arrow from 41102.9,0 to 41102.9,1675 nohead front
set label "Mean $41.1k" at 41102.9,1025 # collides with ytic
# third quartile
set arrow from 53750,0 to 53750,1675 nohead front
set label "3Q $53.7k" at 53750,1050
# first stddev
set arrow from 90101.39,0 to 90101.39,1675 nohead front
set label "1σ $90.1k" at 90101.39,1000

set arrow from 139101.1,0 to 139101.1,1675 nohead front
set label "2σ $139k" at 139101.1,1000

set arrow from 188100.2,0 to 188100.2,1675 nohead front
set label "3σ $188k" at 188100.2,1000

# attempt to make bar labels
#histtabledata = 'freq_temp.dat'
#set table $histtabledata
plot 'wilkinsburg-residence-countytotal.csv' using (rounded($1)):(1) smooth frequency with boxes linewidth 50 #, '' using 0:($1+.1):(sprintf("%.0f",$1)) with labels notitle
#unset table
# plot $histtabledata using 1:($2 == 0 || strcol(3) eq "u" ? 1/0 : $2) with labels notitle
#plot $histtabledata using 1:2 with labels notitle
