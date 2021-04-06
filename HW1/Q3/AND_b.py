# -*- coding: utf-8 -*-
"""
Created on Thu Jan 28 15:19:49 2021

@author: wwis17
"""
import numpy as np
import matplotlib.pyplot as plt

# x = [bias, x1 ,x2]
X = np.array([[1,0,0], [1,0,1], 
              [1,1,0], [1,1,1]])
y = np.array([0,0,0,1])

#weights
w = np.array([0.1,0.3,0.5])
print("the initial weights is:", w)

def hard_limiter(x):
    return 1 if x>=0 else 0

#learning rate
lr=1
weight_change = np.copy(w)

for j in range(10):
    for i in range(4):
        v = hard_limiter(np.dot(X[i,:],w))
        e = y[i]-v
        w += lr*e*X[i,:]
        weight_change = np.append(weight_change,w)
        i += 1
        

total_iter = i*(j+1)
weight_change = np.reshape(weight_change, (total_iter+1,3))
print("the final weights is:", weight_change[-1])

step = np.arange(total_iter+1)

plt.figure()
plt.plot(step, weight_change[:,0],label = 'weight[0]')
plt.plot(step, weight_change[:,1],label = 'weight[1]')
plt.plot(step, weight_change[:,2],label = 'weight[2]')
plt.legend()
plt.xlabel("step")
plt.ylabel("weights")
plt.show()


