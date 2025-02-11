# Load relevant libraries
library(tidyverse)
library(caret)
library(e1071)
library(splines)
library(glmnet)

# Load the wine quality data set 
wine <- read.csv('winequality-red.csv')

# Split the data with a seed for repeatability (training = 70%, testing = 30%)
set.seed(818)
trainIndex <- createDataPartition(wine$quality, p = 0.7, list = FALSE)
wine_train <- wine[trainIndex,]
wine_test <- wine[-trainIndex,]

# Linear Regression ( Part 1a )
# Use all available features
linear_model <- lm(quality ~ alcohol, data = wine_train)
summary(linear_model)

# Polynomial Regression ( Part 1b )
# Use a polynomial term with degree 3
polynomial_model <- lm(quality ~ poly(alcohol, 2), data = wine_train)
summary(polynomial_model)

# Multi-Linear Regression ( Part 1c )
# Use all available features
multi_linear_model <- lm(quality ~ ., data = wine_train)
summary(multi_linear_model)

# Natural Cubic Spline ( Part 1d )
# Use a natural spline with 5 degrees of freedom
spline_model <- lm(quality ~ ns(alcohol, df = 5) + ., data = wine_train)
summary(spline_model)

# Linear model prediction and MSE calculation
linear_pred <- predict(linear_model, newdata = wine_test)
linear_mse <- mean((wine_test$quality - linear_pred)^2)

# Polynomial model prediction and MSE calculation
poly_pred <- predict(polynomial_model, newdata = wine_test)
poly_mse <- mean((wine_test$quality - poly_pred)^2)

# Multi-linear model prediction and MSE calculation
multi_pred <- predict(multi_linear_model, newdata = wine_test)
multi_mse <- mean((wine_test$quality - multi_pred)^2)

# Spline model prediction and MSE calculation
spline_pred <- predict(spline_model, newdata = wine_test)
spline_mse <- mean((wine_test$quality - spline_pred)^2)

# Print MSE for each model
print(paste("Linear Model MSE: ", linear_mse))
print(paste("Polynomial Model MSE: ", poly_mse))
print(paste("Multi-linear Model MSE: ", multi_mse))
print(paste("Spline Model MSE: ", spline_mse))

# Visualize the linear model performance
ggplot(data = wine_test, aes(x = quality, y = linear_pred)) + 
  geom_point() + 
  geom_abline(slope = 1, intercept = 0, color = "red") + 
  labs(x = "Actual Quality", y = "Predicted Quality", title = "Linear Model")

# Visualize the Polynomial model performance
ggplot(data = wine_test, aes(x = quality, y = poly_pred)) + 
  geom_point() + 
  geom_abline(slope = 1, intercept = 0, color = "red") + 
  labs(x = "Actual Quality", y = "Predicted Quality", title = "Polynomial Model")

# Visualize the Multi-linear model performance
ggplot(data = wine_test, aes(x = quality, y = multi_pred)) + 
  geom_point() + 
  geom_abline(slope = 1, intercept = 0, color = "red") + 
  labs(x = "Actual Quality", y = "Predicted Quality", title = "Multi-linear Model")

# Visualize the Natural Spline model performance
ggplot(data = wine_test, aes(x = quality, y = spline_pred)) + 
  geom_point() + 
  geom_abline(slope = 1, intercept = 0, color = "red") + 
  labs(x = "Actual Quality", y = "Predicted Quality", title = "Spline Model")

# # Selecting The best Features for the linear and polynomial models
# # Get the feature names
# features <- colnames(wine_train)[-which(colnames(wine_train) == "quality")]
# 
# # Initialize minimum MSE and best feature variables
# min_mse <- Inf
# best_feature <- NULL
# 
# # Loop over features for Linear Model
# for (feature in features) {
#   # Fit the model
#   model <- lm(paste("quality ~", feature), data = wine_train)
#   
#   # Make predictions
#   preds <- predict(model, newdata = wine_test)
#   
#   # Calculate MSE
#   mse <- mean((wine_test$quality - preds)^2)
#   
#   # Update minimum MSE and best feature
#   if (mse < min_mse) {
#     min_mse <- mse
#     best_feature <- feature
#   }
# }
# 
# # Print best feature and minimum MSE for Linear Model
# print(paste("Best feature for Linear Model: ", best_feature))
# print(paste("Minimum MSE for Linear Model: ", min_mse))
# 
# # Reinitialize minimum MSE and best feature variables for Polynomial Model
# min_mse <- Inf
# best_feature <- NULL
# 
# # Loop over features for Polynomial Model
# for (feature in features) {
#   # Fit the model
#   model <- lm(paste("quality ~ poly(", feature, ", 2)"), data = wine_train)
#   
#   # Make predictions
#   preds <- predict(model, newdata = wine_test)
#   
#   # Calculate MSE
#   mse <- mean((wine_test$quality - preds)^2)
#   
#   # Update minimum MSE and best feature
#   if (mse < min_mse) {
#     min_mse <- mse
#     best_feature <- feature
#   }
# }
# 
# # Print best feature and minimum MSE for Polynomial Model
# print(paste("Best feature for Polynomial Model: ", best_feature))
# print(paste("Minimum MSE for Polynomial Model: ", min_mse))
# 
### Alcohol was shown to be the best predictor for polynomial and linear models