# Set Working Directory 
setwd("/Users/saranram/Desktop/GEM/INST737/Project")

library(readxl)

# Set data variable 
LoL <- read_excel("LoL.xlsx")


# Remove all categorical variables to allow for Neural Network to work 
Lol_final <- subset(LoL, select = -c(Name,Class,Role,Tier,Patch))

# shows all the columns that are now in our data
data.frame(colnames(Lol_final))


# We need to normalize our independent variable with this function 
normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

# apply normalization to entire data frame
LoL_norm <- as.data.frame(lapply(Lol_final,normalize))

# This is the dataset we will be using so we attach for ease of use 
attach(Lol_final)

# TESTING AND TRAINING 
# Training is 90% of data and Testing is 10%
LoL_train <- LoL_norm[1:670,]
LoL_test <- LoL_norm[671:743,]


# MULTI lAYER PERCEPTRON 
#install.packages("neuralnet")
library(neuralnet)

# Our exhaustive testing models with different number of hidden layers
LoL_model <- neuralnet(formula = Score ~., data = LoL_train)

LolHiddenModel1 <-neuralnet(formula = Score ~., data = LoL_train, hidden = 2 )

LolHiddenModel2 <-neuralnet(formula = Score ~., data = LoL_train, hidden = 3 )

LolHiddenModel3 <-neuralnet(formula = Score ~., data = LoL_train, hidden = 4 )


# Visualize Network Topology 

plot(LoL_model)

plot(LolHiddenModel1)

plot(LolHiddenModel2)

plot(LolHiddenModel3)


# NEXT we want to predict on testing set
model_results <- compute(LoL_model, LoL_test)

model_results1 <- compute(LolHiddenModel1, LoL_test)

model_results2 <- compute(LolHiddenModel2, LoL_test)

model_results3 <- compute(LolHiddenModel3, LoL_test)

# Compute output function has two components 
# $net.result: info about the predicted value 
# $neurons: info about the neurons 


# PREDICTING ON TESTING SET 
# This is a numeric prediction problem, not classification 
# no confusion matrix 
# correlation between real and predicted values 

# obtain predicted strength values OR VALS OF DESIRED VARIABLE 
predicted_Score <- model_results$net.result

predicted_scorehidden1 <- model_results1$net.result

predicted_scorehidden2 <- model_results2$net.result

predicted_scorehidden3 <- model_results3$net.result

# Neuron info variable is set 
ScoreHiddenNeurons1 <- model_results1$neurons

ScoreHiddenNeurons2 <- model_results2$neurons
ScoreHiddenNeurons3 <- model_results3$neurons

# Gives the individual values for each neuron of the 71 neurons in every variable column for the three neural network models 
ScoreHiddenNeurons1
ScoreHiddenNeurons2
ScoreHiddenNeurons3

# Examine the correlation between predicted an actual values 
# 3 hidden layers gives the highest cor value 
cor(predicted_Score,LoL_test$Score)

cor(predicted_scorehidden1,LoL_test$Score)

cor(predicted_scorehidden2,LoL_test$Score)

cor(predicted_scorehidden3,LoL_test$Score)



