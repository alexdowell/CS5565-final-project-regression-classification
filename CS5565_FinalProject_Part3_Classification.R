# Load the necessary libraries
library(readr)
library(dplyr)
library(caret)
library(e1071)
library(tree)

# Load the data
df <- read_csv("data.csv")

# Remove the last column if it contains only NA's
if(all(is.na(df[,ncol(df)]))){
  df <- df[,-ncol(df)]
}

# First, let's rename the columns to replace spaces with underscores.
names(df) <- gsub(" ", "_", names(df))

# Convert 'diagnosis' to a binary numeric
df$diagnosis <- ifelse(df$diagnosis == "M", 1, 0)

# Split the data into train and test sets
set.seed(123) # for reproducibility
indices <- sample(1:nrow(df), size = 0.7*nrow(df)) 
train <- df[indices, ]
test <- df[-indices, ]

# Remove 'id' column
train <- subset(train, select = -id)
test <- subset(test, select = -id)

train$diagnosis <- factor(train$diagnosis, levels = c(0, 1))
test$diagnosis <- factor(test$diagnosis, levels = c(0, 1))

# 1) Classification Models: Logistic Regression and Linear Discriminant Analysis
# a) Logistic Regression
logistic_model <- train(diagnosis ~ ., data = train, method = "glm", family = "binomial")
logistic_predictions <- predict(logistic_model, newdata = test)
logistic_predictions <- factor(logistic_predictions, levels = levels(test$diagnosis))
confusionMatrix(logistic_predictions, test$diagnosis)

# b) Linear Discriminant Analysis
lda_model <- train(diagnosis ~ ., data = train, method = "lda")
lda_predictions <- predict(lda_model, newdata = test)
confusionMatrix(lda_predictions, test$diagnosis)

# 2) Tree Classifier
tree_model <- tree(diagnosis ~ ., data = train)
plot(tree_model)
text(tree_model, pretty = 0)

tree_predictions <- predict(tree_model, newdata = test, type = "class")
confusionMatrix(tree_predictions, test$diagnosis)

# 3) Support Vector Classifier
# Train the SVM model using only "radius_mean" and "texture_mean"
dat <- train
svmfit <- svm(diagnosis ~ radius_mean + texture_mean, data = dat, kernel = "linear", cost = 10, scale = TRUE)

# Subset your data to include only the two variables of interest and the 'diagnosis' column
plot_dat <- dat[, c("radius_mean", "texture_mean", "diagnosis")]

# Plot the SVM model
plot(svmfit, plot_dat)

tune.out <- tune(svm, diagnosis ~ radius_mean + texture_mean, data = dat, kernel = "linear", ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))
summary(tune.out)

bestmod <- tune.out$best.model
summary(bestmod)






