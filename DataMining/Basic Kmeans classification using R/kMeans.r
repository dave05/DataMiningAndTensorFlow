#Implementaion of kMeans Clustering algorithm. 

setwd("C:/Users/dawit/Google Drive/Data Mining/Assignments/Assig 3")
#dataset = "kMeansDataset/twoCircles.txt"
#dataset = "kMeansDataset/twoEllipses.txt"
#dataset = "kMeansDataset/fourCircles.txt"
#dataset = "kMeansDataset/iris.txt"
dataset = "kMeansDataset/t4.8k.txt"

max_Iter = 200  #maximum number of iterations.
epsilon = 0.001  #threshold
X=as.matrix(read.table(dataset))
plot(X[,1],X[,2])
K=5 # Depending on the plot

N=dim(X)[1]			
d=dim(X)[2]			
ids=sample(1:N,K) #ids is the list of points that are chosen randomly as the initial centres.
C=X[ids,]#This is  initial means..
myCluster = matrix(0,1,N)#This is to hold the cluster assignment for each points..

breakPt = 0
totalIteration=0
for(iter in 1:maxIter){ #as long maximum number of iterations has been reachdelta.
  
  # Classifying the data into clusters
  
  for(iter1 in 1:N){
    difference = c()
  
    for(means1 in 1:K){
      delta = 0
      for(d1 in 1:d){
        delta = delta + ((C[means1,d1]-X[iter1,d1])*(C[means1,d1]-X[iter1,d1]))
      }
      difference = append(difference,sqrt(delta))
    }
    myCluster[1,iter1] = which.min(difference)
   
  }
  
  # New values of C=0 and counts=0
  initial = c()
  for(means2 in 1:K){
    for(d2 in 1:d){
      initial = append(initial,0)
    }
  }
  initialC = matrix(initial,K,d)
  clusterCount = c()
  for(means3 in 1:K){
    clusterCount = append(clusterCount,0)
  }
  
  # counts in each cluster
  for(means4 in 1:N){
    for(d3 in 1:d){
      initialC[myCluster[1,means4],d3] = initialC[myCluster[1,means4],d3] + X[means4,d3]
    }
    clusterCount[myCluster[1,means4]] = clusterCount[myCluster[1,means4]] + 1
  }
  
  # Calculating means and replacing it
  for(means2 in 1:K){
    for(d2 in 1:d){
      initialC[means2,d2] = initialC[means2,d2] / clusterCount[means2]
    }
  }
  
  #  calculating the delta between the new and old mean and checking for breakpoint if delta<=epsilon
  for(means5 in 1:K){
    delta = 0
    for(d4 in 1:d){
      delta = delta + ((C[means5,d4]-initialC[means5,d4])*(C[means5,d4]-initialC[means5,d4]))
    }
    if(delta<=epsilon){
      breakPt = 1
      #break
    }
  }
 #Assigning C the new means 
  C = initialC
  
  if(breakPt==1){
    break
  }
  totalIteration=totalIteration+1
}

plot(X,col = myCluster)
