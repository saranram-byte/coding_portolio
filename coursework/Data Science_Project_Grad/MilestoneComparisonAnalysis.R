setwd("/Users/saranram/Desktop/GEM/INST737/Project")

library(readxl)
library(dplyr)
#install.packages("mxnet")
LoL <- read_excel("LoL.xlsx")

Lol_final <- subset(LoL, select = -c(Name,Class,Role,Tier,Patch))


# Load the librar
#install.packages("mlbench")
library(mlbench)
library(caret)
# load the dataset

attach(Lol_final)

# prepare training scheme, this time having a number of repeats as well and changin ghte method 
control <- trainControl(method = "repeatedcv", number =10, repeats = 3)


Lol_df <- data.frame(LoL)

Lol_df <- Lol_df[, -1]

# classifier is created for our random forest
Lol_df <- Lol_df %>% 
  mutate(Champion_Health = case_when( (Score >= 1 & Score <=20.99)~"Poor", 
                                      (Score >= 21.00 & Score <= 39.99) ~ "Moderate",
                                      (Score >= 40.00 & Score <=59.99) ~ "Normal",
                                      (Score >= 60 & Score <=79.99) ~ "Above Average",
                                      (Score >= 80.00)~"Overpowered"))




# RANDOMIZING 
set.seed(12345)

# factor all categorical variables 
Lol_df$Champion_Health <- as.factor(Lol_df$Champion_Health)
Lol_df$Class<-as.factor(Lol_df$Class)
Lol_df$Role<-as.factor(Lol_df$Role)
Lol_df$Tier<-as.factor(Lol_df$Tier)


# train the Neural Network 
set.seed(7)
modelNN <- train(Score~., data = Lol_final, method ="neuralnet", trControl = control)

# Train the RF model
set.seed(7)
modelRF <- train(Score~., data = Lol_final, method ="rf", trControl = control, verbose = FALSE)
# train the SVM model 
set.seed(7)
modelSVM <- train(Score~., data = Lol_final, method ="svmRadial", trControl = control)

#collect resamples 
results <- resamples(list(NN = modelNN, RF = modelRF, SVM = modelSVM))

# summarize the distributions 
summary(results)
#boxplots of results 
bwplot(results)
dotplot(results)

