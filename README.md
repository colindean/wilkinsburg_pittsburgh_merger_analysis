# Wilkinsburg and Pittsburgh Annexation/Merger Analysis

Quick links:

* [Tax Graph](wilkinsburg_pittsburgh_merger_taxes.svg)
* [Tax Calculator](calculator.html)

This little site contains some documents, graphs, and programs to analyze the proposed Wilkinsburg/Pittsburgh Annexation/Merger.

Share this site with a more speakable URL: [`j.mp/cd-wilk-pgh-merger`](https://bit.ly/cd-wilk-pgh-merger) or scan this convenient QRcode with your smartphone's Camera app or QRCode reader app to geta link to this page.

![QRcode to the link above](bitly-qrcode.png)

## What do I do with this information?

I believe that it's important to make informed decisions supported by careful analysis of data.
It's on you to decide if the change in taxation is worth it for yourself, but consider also your neighbors.

## Tax Calculator

The [Tax Calculator](calculator.html) shows what your household's income and property taxes would be in two scenarios:

1. a full annexation of Wilkinsburg and merger of the school districts
2. a merger of the school districts but no annexation of the borough

_(A third scenario, a municipal only combination without school district, is not possible and was removed upon this realization.)_

## Tax Graphs

The heat map charts the percentage change difference when accounting for earned income taxes and real estate and school district property tax going from Wilkinsburg to Pittsburgh under the proposed annexation.
The white line is "no change" while blue means lower taxes and red means higher taxes.
The scale on the right of each graph shows the gravity of the change indicated by the darkness of the color.

:lightbulb: The top right graph, _Actual Dollar Change in Total Taxes, Full Merger_, is probably the most relevant to viewers.

Three version of the graph are provided:

1. a [scalable version](wilkinsburg_pittsburgh_merger_taxes.svg) that should look good on all screens and when printed (SVG)
2. a [compressed version](wilkinsburg_pittsburgh_merger_taxes.png) that's easy to share on social media (PNG)
2. a [more compressed version](wilkinsburg_pittsburgh_merger_taxes.webp) that's smaller for email and mobile phones (WEBP)

### Walkthrough

The coloration of the graph is kind of like heat: blue means taxes go down, red means taxes go up. The darker the color, the deeper the change. The white line that is approximately diagonal is where there is ultimately no change in taxation.

The graphs are quite simple math but I've chosen the ranges based on some heuristics:

* The range for property value is based on March 2022 county assessment data from WPRDC for the whole municipality, but residences only.
  * The mean assessed value is around $48,000 in the standard deviation is about $52,500. I chose zero as the starting point for the benefit of renters and a little more than three standard deviations above the mean, approximately $220,000, as the max for that axis.
* For earned income taxes, I chose $15,000 as approximately full-time minimum wage and $300,000 as a two-income, highly-skilled professional household. I don't know where I can get better data on incomes so if you have a suggestion I'm all ears.
  * Noted on the graphs are the median income and 62% mark according to the US Census Bureau.

It's important to note that _renters_ aren't well represented on the graphs
because their property taxes are zero: they do not pay property tax directly.
The owner of the property does.
Working renters — 65% of Wilkinsburg residents rent — can expect to see a net tax increase in the event of a full merger or school district only merger
unless property owners lower rent voluntarily commensurate with their
lower property tax burden or through an act of borough or city government.
So, if this series of graphs had a height relative to the percentage of residents at the crosspoint,
some 65% of the volume would be at the very bottom of the graph, lessened only
by the percentage of renters who do not have earned income.

The City of Pittsburgh parks tax of 0.5 mills is included in real estate tax
calculations as of 7 November 2021.

### A quick refresher on statistics

The graphs bear some abbreviations of statistical terminology to help explain _where_ in the dataset some real numbers are.

|Symbol|Term|Meaning|
|---|---|---|
|1Q|First [quartile](https://en.wikipedia.org/wiki/Quartile)|25% or 1/4 are below this level, 75% or 3/4 are above it|
|Med|[Median](https://en.wikipedia.org/wiki/Median)|Approximately 50% are below and above this level, also called _second quartile_|
|3Q|Third [quartile](https://en.wikipedia.org/wiki/Quartile)|75% or 3/4 are below this level, 25% or 1/4 are above it|
|x̄|[Mean](https://en.wikipedia.org/wiki/Mean)|The mathematical average, the sum of the amounts divided by the count of amounts|
|σ / stddev|[Standard deviation](https://en.wikipedia.org/wiki/Standard_deviation)|A measure of variation from the mean; the smaller the stddev, the closer in general the amounts are to the mean|
|1σ/2σ/3σ|First/second/third standard deviation|The number of standard deviations away from the mean, see also [68-95-99.7 rule](https://en.wikipedia.org/wiki/68%E2%80%9395%E2%80%9399.7_rule).|

## Future Work

What I would love to do is somehow scale this or carve out areas on the graph that include various percentages of the Wilkinsburg population.
The graphs do indicate the median household income with a vertical line but
I don't have any other data about household incomes in order to find where on
the map the majority of Wilkinsburg residents are. According to Census Bureau
data, approximately 62% of Wilkinsburg households are under $50,000 per year.
I have a line representing that figure on the graph.

We do know from the USCB ACS that approximately 65% of Wilkinsburg residents
are renters, but we don't know how many are working and thus have earned income.
If we knew that breakdown, it would be easier to add a third dimension to the
graphs reflecting the percentage of the population likely to be at a section of
the graph at each coordinate.

### Help Wanted

I could use a GNUplot expert to help me clean up the code and help make the color changes more stark.

I could use someone interested in make a better small static website for this. I'm using GitHub Pages for now and it's adequate but it could be snazzier.

Find a problem? Want to say thanks? Raise an [issue](https://github.com/colindean/wilkinsburg_pittsburgh_merger_analysis/issues/new).

All code for this mini-site, documents, and graphs are available [here](https://github.com/colindean/wilkinsburg_pittsburgh_merger_analysis).

## Quality Assurance

All sources of information should be cited.
If you find a fact or figure that isn't cited and it is represented as factual,
please raise an issue on the repository.

The figures provided by these materials should be treated as estimates.
Some information may grow out of date over time.

I try to act on bug reports quickly.
However, as a volunteer, most of my time spent on this is on the weekends and late evenings,
so there could be a few days delay before I'm able to address your concerns.

## Who Built This?

This information is collected and presented principally by Colin Dean, a long-time resident of Wilkinsburg.
There may be other [contributors listed on GitHub](https://github.com/colindean/wilkinsburg_pittsburgh_merger_analysis/graphs/contributors).

## How May I Use This?

[![Creative Commons License](https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
Any graphs, their source code, and associated data analysis code are licensed under a [Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

[![Affero General Public License](https://www.gnu.org/graphics/agplv3-155x51.png)](https://www.gnu.org/licenses/agpl-3.0.en.html)
Any other source code is licensed under the [Affero General Public License 3.0](https://www.gnu.org/licenses/agpl-3.0.en.html), except where noted.
