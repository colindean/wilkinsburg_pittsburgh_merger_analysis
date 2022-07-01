import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1 import make_axes_locatable
import numpy as np
import pylab
import seaborn as sns

from tax_rates import Wilkinsburg, Pittsburgh

# Data for plotting
wages_range = np.arange(start=15000.0, stop=300000.0, step=5000.0)
prop_assess_range = np.arange(start=0.0, stop=220000.0, step=20000.0)

X, Y = pylab.meshgrid(wages_range, prop_assess_range)


def Z_func(wages, assessment):
    wage_diff = Pittsburgh.wage_tax(wages) - Wilkinsburg.wage_tax(wages)
    prop_diff = Pittsburgh.property_tax(assessment) - Wilkinsburg.property_tax(assessment)
    return wage_diff + prop_diff


Z = Z_func(X, Y)


# s = 1 + np.sin(2 * np.pi * t)

fig, ax = plt.subplots()
# ax.plot(t, s)
sns.heatmap(Z, center=0, ax=ax)

# im = ax.imshow(Z, cmap=pylab.cm.RdBu)

ax.set(xlabel='wages ($)', ylabel='property assessment ($)',
       title='Raw change in assessment')
ax.grid()

# create an axes on the right side of ax. The width of cax will be 5%
# of ax and the padding between cax and ax will be fixed at 0.05 inch.
# divider = make_axes_locatable(ax)
# cax = divider.append_axes("right", size="5%", pad=0.05)

# plt.colorbar(im, cax=cax)

fig.savefig("test.png")
plt.show()
