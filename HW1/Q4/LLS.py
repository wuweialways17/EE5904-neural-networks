# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 17:23:04 2021

@author: wwis17
"""
"""LLS Method"""
import numpy as np
import matplotlib.pyplot as plt
from numpy.linalg import inv

# x = [bias, x]
X = np.array([[1,0.5],[1,1.5],[1,3.0],[1,4.0],[1,5.0]])

d = np.array([8.0,6.0,5,2,0.5])


X_trans = np.transpose(X)
X_trans_inv = inv(np.dot(X_trans,X))

temp = np.dot(X_trans_inv,X_trans)
w = np.dot(temp,d)


x = np.arange(6)

plt.figure()
plt.plot(x, w[1]*x+w[0],label = 'LLS fitting result')
plt.scatter(X[:,1], d, color = 'red', label='given data pairs')
plt.legend()
plt.xlabel("x")
plt.ylabel("y")
plt.show()

print('the final weight is:',w)



