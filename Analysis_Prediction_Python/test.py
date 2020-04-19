from matplotlib import pyplot as plt
import mplcursors
from pandas import DataFrame

df = DataFrame(
    [("Alice", 163, 54),
     ("Bob", 174, 67),
     ("Charlie", 177, 73),
     ("Diane", 168, 57)],
    columns=["name", "height", "weight"])
scatter1 = df.plot.scatter("height", "weight")
mplcursors.cursor(scatter1, hover=True).connect("add",
    lambda sel: sel.annotation.set_text(
        f'{df["name"][sel.target.index]}\nHeight: {df["height"][sel.target.index] / 100} m\nWeight: {df["weight"][sel.target.index]} kg'))
plt.show()