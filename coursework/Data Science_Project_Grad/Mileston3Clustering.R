# set working directory 
setwd("/Users/saranram/Desktop/GEM/INST737/Project")
# library for reading the League of Legends Data 
library(readxl)

# Assign variable and load necessary libraries 
LoL <- read_excel("LoL.xlsx")
library(factoextra)
library(NbClust)

# Data that REMOVES ALL CATEGORICAL VARIABLES
Lol_final <- subset(LoL, select = -c(Name,Class,Role,Tier,Patch))

# load data and scale( normalize to compare data measured at different scales)
# NECESSARY TO NORMALIZE SO WE SEE ALL VALS ARE SIMILAR ACROSS THE BOARD 
df <- scale(Lol_final)

# n start for 100 random initilization (runs 100, picks best )
# 2 represents the number of clusters 
k2 <- kmeans(df, centers = 2, nstart = 100)
k2
# Visualize it with this command, fviz_cluster(output,original data) 
fviz_cluster(k2,data = df)

# BEST K VALUE? ELBOW METHOD
fviz_nbclust(df,kmeans,method ="wss")

# now with this number identified(2) we can keep this input in our kmeans function
# we believe the break appears at the 2 
k2 <- kmeans(df, centers = 2, nstart = 100)

# Visualize model 
fviz_cluster(k2,data = df)

# we can get the cluster sizes with this function
k2$size


### HIERARCHICAL CLUSTERING #####
# install.packages("cluster")
library(cluster)
#Dissimilarity matrix 
d <- dist(df, method = "euclidean" )

hc1 <- hclust(d, method = "complete" )



# Cut the tree into 5 clusters
cl_members <- cutree(tree = hc1, k = 5)


# Plot the dendrogram
plot(x = hc1, labels = row.names(hc1), cex = 0.5)
rect.hclust(tree = hc1, k = 5, which = 1:5, border = 1:5, cluster = cl_members)

# gets the number of data points per cluster 
table(cl_members)



##### DENSITY BASED CLUSTERING ######

# load the data 
df <- Lol_final[,3:5]

# compute DBSCAN using fpc package 
# install.packages("fpc")
library("fpc")
library(factoextra)
set.seed(123)
# eps is usually min distance and min pts is the minimum points 
db <- fpc::dbscan(df,eps = 0.15, MinPts = 5)

#check db, cluster 0 are outliers 
db

#Plot DBSCAN results(notice outliers)
fviz_cluster(db, data = Lol_final)
#All the points in black are OUTLIERS(THE INDIVIDUAL DATA POINTS )


