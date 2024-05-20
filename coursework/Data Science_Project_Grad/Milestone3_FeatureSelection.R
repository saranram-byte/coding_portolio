# set working directory 
setwd("/Users/saranram/Desktop/GEM/INST737")

library(readxl)

# Assign variable and load necessary libraries 
LoL <- read_excel("LoL.xlsx")
Lol_final <- subset(LoL, select = -c(Name,Class,Role,Tier,Patch))

# Load more libraries and attach the dataset
library(MASS)
library(ggplot2)
attach(Lol_final)


## FILTER METHOD: SVM ## 
# Sample the dataset. The return for this is row nos. 
set.seed(1)
# 0.8 represents the selection of 80% which creates the 80:20 ratio between training and testing
row.number <- sample(1:nrow(Lol_final), 0.8*nrow(Lol_final))
train = Lol_final[row.number,]
test = Lol_final[-row.number,]
dim(train)
dim(test)


# correlations between all features. Lets only look at medvcolumn 
corrV <- cor(train)

#Building correplot to visualize the correlation matrix.
library(corrplot)
# We decided to remove "Trend" variable with this visualization 
corrplot(cor(train), method = "number", is.corr = FALSE)
library(kernlab)

# Now lets make default model
model1 <- ksvm(log(Score)~`Pick %`+ `Ban %` + `Win %` + Trend, data = train, kernel = "rbf")

# run the model
model1

# Kept kernel the same and removed "Trend" variable  
model2 <- ksvm(log(Score)~`Pick %`+  `Ban %`+ `Win %`, data = train, kernel = "rbf")

#run the model 
model2


## LINEAR REGRESSION WRAPPER ##

# Load Data: predict ozone levels based on weather features 
trainData <- Lol_final
print(head(trainData))

# step 1: Define base intercept only model(no variables)
base.mod <- lm(Score~1, data = trainData)

#step 2: Full model with all predictors 
all.mod <- lm(trainData$Score~.,data = trainData)

# step 3: Perform step-wise algorithm. direction = both, forward, backward
stepMod <- step(base.mod, scope = list(lower = base.mod, upper = all.mod), direction = "forward", trace = 0, steps = 1000)

stepMod
# LOOK AT CALL FOR THE BEST VARIABLE FORMULA 
# lm(formula = Score ~ `Pick %` + `Win %` + `Ban %` + `Role %` + 
# Trend, data = trainData)



## HYBRID METHOD IN CLASS##
# Load necessary 
library(mlbench)
library(caret)

# define the control using a random forest model trained with CV
control <- rfeControl(functions = rfFuncs, method = "cv", number = 10)

# run the RFE algorithm 
results <- rfe(Lol_final[,2:7], as.matrix(Lol_final[,1]),
               sizes = c(1:7), rfeControl = control)

# plot the results 
plot(results, type = c("g", "o"))

# list the chosen features
predictors(results)




