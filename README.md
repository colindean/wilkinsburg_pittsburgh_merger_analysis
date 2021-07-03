# Wilkinsburg and Pittsburgh merger analysis

Quick links:

* [Tax Graph](wilkinsburg_pittsburgh_merger_taxes.svg)
* [Tax Calculator](calculator.html)

This little site contains some documents, graphs, and programs to analyze the proposed Wilkinsburg/Pittsburgh Annexation/Merger.

Share this site with a more speakable URL: [`j.mp/cd-wilk-pgh-merger`](https://bit.ly/cd-wilk-pgh-merger) or scan this convenient QRcode with your smartphone's Camera app or QRCode reader app to geta link to this page.

![QRcode to the link above](bitly-qrcode.png)

## Tax Calculator

The tax calculator shows what your income and property taxes would be in two scenarios: a full merger and a merger that does not include the school district.

## Tax Graphs

The heat map charts the percentage change difference when accounting for earned income tax and real estate and school tax going from Wilkinsburg to Pittsburgh under the proposed merger. Blue means taxes go down, red means taxes go up. The darker the color, the deeper the change. The white line that is approximately diagonal is The sweet spot of no change.

The graphs are quite simple math but I've chosen the ranges based on some heuristics:

* The range for property value is based on June 2021 county assessment data from WPRDC for the whole municipality, but residences only. The mean assessed value is around $41,000 in the standard deviation is about $49,000. Very few are under $20,000 so I chose $20,000 as the starting point and three standard deviations above the mean, approximately $190,000, as the max for that axis.
* For earned income taxes, I chose $15,000 as approximately full-time minimum wage and $300,000 as two income highly skilled professional household. I don't know where I can get better data on incomes so if you have a suggestion I'm all ears.

## Future Work

What I would love to do is somehow scale this or carve out areas on the graph that include various percentages of the Wilkinsburg population.
The graphs do indicate the median household income with a vertical line but I don't have any other data about household incomes in order to find where on the map the majority of Wilkinsburg residents are. According to Census Bureau data, approximately 2/3 of Wilkinsburg households are under $50,000 per year. I don't know how best to represent that in the graph.

### Help Wanted

I could use a GNUplot expert to help me clean up the code and help make the color changes more stark.

I could use someone interested in make a better small static website for this. I'm using GitHub Pages for now and it's adequate but it could be snazzier.

Find a problem? Want to say thanks? Raise an [issue](https://github.com/colindean/wilkinsburg_pittsburgh_merger_analysis/issues/new).

All code for this mini-site, documents, and graphs are available [here](https://github.com/colindean/wilkinsburg_pittsburgh_merger_analysis).
