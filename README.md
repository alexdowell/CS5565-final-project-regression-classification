# CS5565 Final Project: Regression and Classification  

## Description  
This repository contains the final project for **CS5565**, covering regression analysis, feature selection, model optimization, and classification techniques. The project consists of three major parts: regression modeling, feature selection and model optimization, and classification methods using machine learning models.  

## Files Included  

### **Part 1: Regression Analysis**  
- **File:** CS5565_FinalProject_Part1_Regression.R  
- **Topics Covered:**  
  - Linear regression  
  - Polynomial regression  
  - Multi-linear regression  
  - Natural spline regression  
  - Model performance evaluation using Mean Squared Error (MSE)  

### **Part 2: Feature Selection and Model Optimization**  
- **File:** CS5565_FinalProject_Part2_FeatureSelection_ModelOptimizationMethods.R  
- **Topics Covered:**  
  - Forward stepwise selection  
  - Backward stepwise selection  
  - Residual Sum of Squares (RSS) and Adjusted R² analysis  
  - Principal Component Regression (PCR)  

### **Part 3: Classification Models**  
- **File:** CS5565_FinalProject_Part3_Classification.R  
- **Topics Covered:**  
  - Logistic regression  
  - Linear Discriminant Analysis (LDA)  
  - Decision tree classification  
  - Support Vector Machine (SVM) classification  

### **Project Report**  
- **File:** 5565 Final Project.pdf  
- **Contents:**  
  - Summary of regression analysis results  
  - Discussion of feature selection methods and model performance  
  - Interpretation of classification accuracy, sensitivity, and specificity  

## Installation  
Ensure R and the required libraries are installed before running the scripts.  

### Required R Packages  
- tidyverse  
- caret  
- e1071  
- splines  
- glmnet  
- leaps  
- pls  
- tree  

To install the necessary packages, run:  
install.packages(c("tidyverse", "caret", "e1071", "splines", "glmnet", "leaps", "pls", "tree"))  

## Usage  
1. Open RStudio or an R console.  
2. Load the required dataset using `read.csv()`.  
3. Run the script using:  
   source("CS5565_FinalProject_Part1_Regression.R")  
   source("CS5565_FinalProject_Part2_FeatureSelection_ModelOptimizationMethods.R")  
   source("CS5565_FinalProject_Part3_Classification.R")  
4. View model summaries and results in the R console or through generated plots.  

## Example Output  

- **Regression Analysis (Part 1)**  
  - `Linear Model MSE:  0.4599`  
  - `Polynomial Model MSE:  0.4589`  
  - `Multi-Linear Model MSE:  0.4265`  
  - `Spline Model MSE:  0.4231`  

- **Feature Selection (Part 2)**  
  - Forward and backward stepwise selection indicate optimal features.  
  - Principal Component Regression (PCR) results:  
    - `Variance explained: 83.64%`  

- **Classification Models (Part 3)**  
  - **Logistic Regression:** Accuracy = 95.32%  
  - **LDA Model:** Accuracy = 94.74%  
  - **Decision Tree:** Accuracy = 94.74%  
  - **Support Vector Classifier:** Optimized at cost = 5  

## Contributions  
This repository is designed for educational purposes. Feel free to fork and modify the scripts.  

## License  
This project is open for educational and research use.  

---
**Author:** Alexander Dowell  
