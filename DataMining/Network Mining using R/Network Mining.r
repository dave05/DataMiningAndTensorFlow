setwd("C:/Users/dawit/Google Drive/Data Mining/Assignments/Assig 4")

#dataFile = "networkDatasets/karate.txt"
#dataFile = "networkDatasets/HcNetwork.txt"
#dataFile = "networkDatasets/HprdNetwork.txt"
dataFile = "networkDatasets/toyN.txt"
X = as.matrix(read.table(dataFile))
n = max(X)#node with the highest number
A = matrix(0,n,n)#initialize nXn matrix
Data = read.table(dataFile, header=FALSE)
N = dim(X)[1]	#number of rows		
D = dim(X)[2]	#number of columns

#populate A..iterate over X and populate entries in A
for(iter1 in 1:N){
  for(i in 1:D){
    node_1 = Data[iter1, i]
    node_2 = Data[iter1, i+1]
    A[node_1,node_2] = 1
    A[node_2,node_1] = 1
  }
}

#calculating degree distribution
degree = rowSums(A)
maxD = max(degree)#maximum degree count
DegreeCount = matrix(0,maxD,1)#matrix to hold degreeCount
DC = length(degree) #length of the degree count variable

for(i in 1:DC){
   index = degree[i]
   DegreeCount[index,]=DegreeCount[index,]+1
}


#calculating probability distribution
n = colSums(DegreeCount)
r = nrow(DegreeCount)
ProbabilityCount = matrix(0,maxD,1)#matrix to hold probabilityCount

for(i in 1:r){
 ProbabilityCount[i,]=as.double(DegreeCount[i,]/n)
}

x = c()
for (i in 1:length(ProbabilityCount)) {
  x = append(x, i)
}

#calculating clustering coefficient
rowSize = dim(A)[1] #dimension of the adjacency matrix
colSize = dim(A)[2]

neighbourMatrix = matrix(0,rowSize,1)
for(i in 1:rowSize){
  for(j in 1:colSize){
    if(A[i,j]==1){
      neighbourMatrix[i,]= neighbourMatrix[i,]+1
    }
  }
}

InducedMatrix = matrix(0,rowSize,1)

for(k in 1:rowSize){
  r = row(A)[ which(!A[k,] == 0)]
  b = matrix(r)
  
  row_B = dim(b)[1]
  count=0

  for(i in 1:row_B){
    for(j in 1:row_B){
      p=b[i,]
      q=b[j,]
    
      if(A[p,q]==1){
        count=count+1
      }
    }
   }
  InducedMatrix[k,]=count/2
}

ClusterMatrix = matrix(0,rowSize,1)
m=0
n=0
for(i in 1:rowSize){
  m=InducedMatrix[i,]
  n=neighbourMatrix[i,]
  if(n<2){
    ClusterMatrix[i,]=0
  }
  else
    ClusterMatrix[i,]=as.double((2*m)/(n*(n-1)))
}
sum = colSums(ClusterMatrix)
cluster_Value=sum/rowSize
print(cluster_Value)
plot(DegreeCount)#plot degree count
