# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 14:58:53 2021

@author: wwis17
"""
import numpy as np
import matplotlib.pyplot as plt

# x = [bias, x1 ,x2]
X = np.array([[1,0], [1,1]])
y = np.array([1,0])

#weights
w = np.array([0.5,-1])
#w = np.array([0.1,-0.7])

x = np.array([0,1,2])

plt.figure()
plt.axvline(x = (-w[0])/w[1])
plt.scatter(0,0,color = 'red',label = '1')
plt.scatter(1,0,color = 'blue',label = '0')
plt.legend()
plt.xlabel("x1")
plt.show()
