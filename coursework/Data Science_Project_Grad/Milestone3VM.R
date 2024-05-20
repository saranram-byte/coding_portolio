 # set working directory 
setwd("/Users/saranram/Desktop/GEM/INST737/Project")

library(readxl)

# Load data
LoL <- read_excel("LoL.xlsx")
str(LoL)

# Load necessary library and atttach LoL dataset for easy use 
library(dplyr)
attach(LoL)



# Training and Testing sets 
# 90% is 670 
LoL_train <- LoL[1:670,]
LoL_test <- LoL[671:743,]

# Installation of necessary SVM package 
# install.packages("kernlab")
library(kernlab)

# We use the three main variables that have the most influence( Pick %, Ban %, Win %) along with the vanilla dot kernel first 
LoL_regression <- ksvm(Score~`Pick %`+ `Ban %` + `Win %`, data = LoL_train, kernel = "vanilladot")

#look at trianing error and other info about model 
LoL_regression

# We compare our regression with 
LoL_predictions <- predict(LoL_regression, LoL_test)

## IMPROVING MODEL ##
# Opted for the RBF KERNAL to compare to the vanilla kernel to improve the model 
LoL_regression_rbf <- ksvm(Score~`Pick %`+ `Ban %` + `Win %`, data = LoL_train, kernel = "rbf")

LoL_predictions_rbf <- predict(LoL_regression_rbf,LoL_test)

# Run the model 
LoL_regression_rbf
# Training error went down with the "RBF" kernel


# Now for the RMSE value for both 
#load the library 
install.packages("Metrics")
library(Metrics)
rmse(LoL_predictions, LoL_test$Score)
rmse(LoL_predictions_rbf, LoL_test$Score)

# Even with the RBF RMSE value being higher than the Vanilladot kernel, our training error is lower 