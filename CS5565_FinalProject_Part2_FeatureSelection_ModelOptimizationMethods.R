# First, import necessary libraries and load the data
library(leaps)
library(pls)
library(ggplot2)
library(readr)

# Load the data
df <- read_csv('Life Expectancy Data.csv')

# Because the 'Status' column is categorical, we'll have to convert it to a numerical factor for model fitting
df$Status <- as.numeric(factor(df$Status))

# First, let's rename the columns to replace spaces with underscores.
names(df) <- gsub(" ", "_", names(df))

# Split the data into train and test sets
set.seed(1) # for reproducibility
indices <- sample(1:nrow(df), size = 0.7*nrow(df)) 
train <- df[indices, ]
test <- df[-indices, ]

# Remove country names from the dataset
train <- subset(train, select = -Country)
test <- subset(test, select = -Country)

# 1) Forward Stepwise Selection
regfit.fwd <- regsubsets(`Life_expectancy` ~ ., data = train, nvmax = 20, method = "forward")
summary(regfit.fwd)

# 2) Backward Stepwise Selection
regfit.bwd <- regsubsets(`Life_expectancy` ~ ., data = train, nvmax = 20, method = "backward")
summary(regfit.bwd)

# Plotting RSS and Adjusted R2
# a) Forward Features
reg.summaryfwd <- summary(regfit.fwd)
par(mfrow = c(1, 2))
plot(reg.summaryfwd$rss, xlab = "Number of Variables", ylab = "RSS", type = "l")
plot(reg.summaryfwd$adjr2, xlab = "Number of Variables", ylab = "Adjusted RSq", type = "l")

# b) Backward Features
reg.summarybwd <- summary(regfit.bwd)
par(mfrow = c(1, 2))
plot(reg.summarybwd$rss, xlab = "Number of Variables", ylab = "RSS", type = "l")
plot(reg.summarybwd$adjr2, xlab = "Number of Variables", ylab = "Adjusted RSq", type = "l")

# 3) PCR
pcr.fit <- pcr(`Life_expectancy` ~ ., data = train, validation = "CV")
summary(pcr.fit)
validationplot(pcr.fit, val.type = "MSEP")
