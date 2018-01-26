
#A skeleton for implementing Naive Bayes Classifier in Python.
## Author: Dawit Beshah/Salem 

import numpy as np
import random
import time
from scipy.stats import norm
trainingFile = "Data Sets/irisPCTraining.txt"
testingFile = "Data Sets/irisPCTesting.txt"

Xtrain = np.loadtxt(trainingFile)

n = Xtrain.shape[0]
d = Xtrain.shape[1]-1
print (n,d)
Xp=Xtrain[Xtrain[:,d]==1,0:d]
Xn=Xtrain[Xtrain[:,d]==-1,0:d]
#calculating the mean for each dimmension for each class
Meanpositive=np.mean(Xp,axis=0)
Meannegative=np.mean(Xn,axis=0)

#calculating the standard deviation for each dimension for each class
Sdpositive=np.std(Xp,axis=0)
Sdnegative=np.std(Xn,axis=0)

#calculating P(C+) and P(C-)
npositives=Xp.shape[0]
nnegatives=Xn.shape[0]
positives=npositives/n
negatives=nnegatives/n

#Training... Collect mean and standard deviation for each dimension for each class..
#Also, calculate P(C+) and P(C-)

#Testing .....
Xtest = np.loadtxt(testingFile)
nn = Xtest.shape[0] # Number of points in the testing data.
# calculating likelyhoods
perditpositive= np.empty((nn,1))
perditnegative= np.empty((nn,1))
perdictions= np.ones((nn,1))

tp = 0 #True Positive
fp = 0 #False Positive
tn = 0 #True Negative
fn = 0 #False Negative
for i in range(0,nn):
	likelypositives = norm.pdf(Xtest[i,0:d],Meanpositive,Sdpositive)
	likelynegatives = norm.pdf(Xtest[i,0:d],Meannegative,Sdnegative)
	perditpositive[i,0]=np.array((np.prod(likelypositives) *  positives))
	perditnegative[i,0]=np.array((np.prod(likelynegatives) *  negatives))
	if(perditnegative[i,0]>perditpositive[i,0]):
		perdictions[i,0]=-1
	if(perdictions[i,0]==1):
		if(Xtest[i,d]==1):
			tp+=1
		else:
			fp+=1
	elif(perdictions[i,0]==-1):
		if(Xtest[i,d]==-1):
			tn+=1
		else:
			fn+=1
accuracy=((tp+tn)/nn)*100
percision=(tp/(tp+fp))*100
recall=(tp/(tp+fn))*100
print("******Output from IrisPC Data Set*****")
print("Accuracy =",accuracy)
print("Percision =",percision)
print("Recall =",recall)



#Iterate over all points in testing data
  #For each point find the P(C+|Xi) and P(C-|Xi) and decide if the point belongs to C+ or C-..
  #Recall we need to calculate P(Xi|C+)*P(C+) ..
  #P(Xi|C+) = P(Xi1|C+) * P(Xi2|C+)....P(Xid|C+)....Do the same for P(Xi|C-)
  #Now that you've calculate P(Xi|C+) and P(Xi|C-), we can decide which is higher 
  #P(Xi|C-)*P(C-) or P(Xi|C-)*P(C-) ..
  #increment TP,FP,FN,TN accordingly, remember the true lable for the ith point is in Xtest[i,(d+1)]

#}

#Calculate all the measures required..
 
