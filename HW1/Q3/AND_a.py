# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 14:58:53 2021

@author: wwis17
"""
import numpy as np
import matplotlib.pyplot as plt

# x = [bias, x1 ,x2]
X = np.array([[1,0,0], [1,0,1], 
              [1,1,0], [1,1,1]])
y = np.array([0,0,0,1])

#weights
w = np.array([-1.5,1,1])
#w = np.array([-2.9,2.3,1.5])

a = w[1]/w[2]
b = -w[0]/w[2]

x = np.array([0,1,1.5])

plt.figure()
plt.plot(x,-(a*x)+b)
plt.scatter(0,0,color = 'blue',label = '0')
plt.scatter(0,1,color = 'blue')
plt.scatter(1,0,color = 'blue')
plt.scatter(1,1,color = 'red',label = '1')
plt.legend()
plt.xlabel("x1")
plt.ylabel("x2")
plt.show()
