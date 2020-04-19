from matplotlib import pyplot as plt
import mplcursors
from pandas import DataFrame
import pickle
import numpy as np 

with open('../ApartmentPrice/Analysis_Prediction_Python/prets_pvols.bin', 'rb') as f:
    pick = pickle.load(f)

point=plt.scatter('pvols','prets',data=pick,c=pick.index ,marker='o')
point
plt.grid(True)
plt.xlabel('expected volatility')
plt.ylabel('expected return')
plt.colorbar(label='Sharpe ratio')
mplcursors.cursor(point)
plt.show()