#!/usr/bin/env python
import pandas as pd
# from ggplot import *
import matplotlib.pyplot as plt
import matplotlib
matplotlib.style.use('ggplot')

# import and massage data
df = pd.read_csv("RVS_report.csv", header=None, names=["att", "date", "num_rvs", ">6mo old"])
df['<6mo old'] = df['num_rvs'] - df['>6mo old']

cols_to_keep = ['att', '<6mo old', '>6mo old']
df_vis = df[cols_to_keep].tail(12)

# df_long = pd.melt(df.tail(12), id_vars=['att'], value_vars=['<6mo old', '>6mo old'])

#ggplot(df_long, aes(x='att', y='value', fill='variable')) +\
#             geom_bar(stat='identity') +\
#             scale_fill_manual(values=c["#404040, #9e2929"])

# initialize vars for categorical axis
att_call = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
att_labels = df_vis.att


df_vis.plot(kind='bar', stacked=True, color=['#666666', '#C94949'])
plt.xticks(att_call, att_labels, rotation=45)
plt.xlabel("Attending")
plt.ylabel("Count")
plt.title("Outstanding RVSs")

plt.show()