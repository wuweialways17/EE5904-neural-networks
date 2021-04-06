# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 17:37:39 2021

@author: wwis17
"""
"""LMS method"""
import numpy as np
import matplotlib.pyplot as plt

# x = [bias, x]
X = np.array([[1,0.5],[1,1.5],[1,3.0],[1,4.0],[1,5.0]])

d = np.array([8.0,6.0,5,2,0.5])

#learning rate
lr = 0.02


w = np.array([1.0,1.0])
print("the initial weights is:", w)

weight_change = np.copy(w)

for j in range(100):
    for i in range(5):
        e = d[i]-np.dot(X[i,:],w)
        w += lr*e*X[i,:]
        weight_change = np.append(weight_change,w)
        
total_iter = i*(j+1)
weight_change = np.reshape(weight_change, (501,2))


print('Final weights is:',w)


step = np.arange(501)
x = np.arange(6)
fig, ax = plt.subplots(2, 1, figsize=(6, 8))
ax[0].plot(step,weight_change[:,0],label='weight')
ax[0].plot(step,weight_change[:,1],label='bias')
ax[0].set_xlabel('setp')
ax[0].set_ylabel('weight')
ax[0].legend()
ax[1].plot(x, w[0]+w[1]*x,label = 'LMS fitting result')
ax[1].scatter(X[:,1],d,color='red',label = 'given data pairs')
ax[1].set_xlabel('x')
ax[1].set_ylabel('y')
ax[1].legend()
plt.tight_layout()

