# Heat Map Chart reflecting percent change in municipal and school tax if Wilkinsburg and Pittsburgh merge

This is a heat map charting the percentage change difference when accounting for earned income tax and real estate and school tax going from Wilkinsburg to Pittsburgh under the proposed merger. Blue means taxes go down, red means taxes go up. The darker the color, the deeper the change. The white line that is approximately diagonal is The sweet spot of no change.

The graph itself is quite simple math but I've chosen the ranges based on some heuristics:

* The range for property value is based on June 2021 county assessment data from WPRDC for the whole municipality, but residences only. The mean assessed value is around $41,000 in the standard deviation is about $49,000. Very few are under $20,000 so I chose $20,000 as the starting point and three standard deviations above the mean, approximately $190,000, as the max for that axis. 
* For earned income taxes, I chose $15,000 as approximately full-time minimum wage and $300,000 as two income highly skilled professional household. I don't know where I can get better data on incomes so if you have a suggestion I'm all ears.

## Future Work

What I would love to do is somehow scale this or carve out areas on the graph that include various percentages of the Wilkinsburg population.

The biggest assumption of this graph is that somebody looking at it is paying property taxes opaquely. That is, they know precisely how much their property tax is or they are paying it as a part of their mortgage, not something rolled into their rent.

I also want to make some more versions of this graph:

1. One that _does not_ include a school district merger so folks can see that effect.
2. One that shows dollar change instead of percentage change, because folks rarely actually remember how much they pay in taxes to be able to multiply it.

### Help Wanted

I could use a GNUplot expert to help me clean up the code and help make the color changes more stark.

I could use someone interested in make a small static website for this. I'll probably get around to this eventually myself but it's low on the priority list until I have more insight to present.