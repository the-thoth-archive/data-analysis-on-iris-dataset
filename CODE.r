### INSTALL AND UPLOAD PACKAGES (COMMENT IF NECESSARY) ###
install.packages("caret")
install.packages("dplyr")
install.packages("ellipse")
install.packages("kernlab")
install.packages("randomForest")
install.packages("timeDate")
library("caret")
library("dplyr")
library("ellipse")
library("ggplot2")
library("lattice")
library("kernlab")
library("randomForest")
library("timeDate")

#### UPLOAD AND CREATE DATASET OBJECTS ###
data(iris) # LOAD THE IRIS DATASET
iris -> dataset # CREATE A DATASET OBJECT
# read.csv("./IRIS_DATASET.csv", header = TRUE, sep = ",") -> dataset # READ THE IRIS DATASET FROM A CSV FILE
class(dataset) # CHECK THE CLASS OF THE DATASET OBJECT
attach(dataset) # ATTACH THE DATASET OBJECT TO THE WORKSPACE

### SPLIT DATA INTO TRAIN/TEST SETS ###
data_split <- createDataPartition(dataset$Species, p = 0.8, list = FALSE) # CREATE A 80/20 SPLIT OF THE DATA FOR TRAINING/TESTING PURPOSES
test <- dataset[-data_split,] # SET 20% OF DATA AS TEST SET
train <- dataset[data_split,] # SET THE REMAINING 80% OF DATA FOR TRAINING

### SEPARATE THE TRAINING DATA FROM THE LABELS ###
x <- dataset[,1:4] # SET THE FIRST 4 COLUMNS AS THE TRAINING DATA
y <- dataset[,5] # SET THE 5TH COLUMN AS THE LABELS

################### DATA SUMMARY ###################
head(dataset) # PRINT THE FIRST 10 LINES OF DATA (AS EXAMPLE)
dim(dataset) # GET DATASET DIMENSIONS (SPACE, ROWS, COLUMNS)
sapply(dataset, class) # SAPPLY() USED TO MAP FUNCTION TO EACH ATTRIBUTE; CLASS FUNCTION RETURNS DATA CLASS TYPE FOR A GIVEN ATTRIBUTE
levels(dataset$Species) # LISTS ALL UNIQUE CLASS LEVELS WITHIN THE SPECIES ATTRIBUTE OF DATASET
percentage <- prop.table(table(dataset$Species)) * 100 # CREATE THE PERCENTAGE VARIABLE AND CALCULATE EACH INDIVIDUAL LEVEL
cbind(freq=table(dataset$Species), percentage=percentage) # LISTS FREQUENCY AND PERCENTAGE OF EACH INDIVIDUAL CLASS LEVEL WITHIN SPECIES ATTRIBUTE
glimpse(dataset) # PRINTS A CONCISE SUMMARY OF THE DATASET
vis_miss(dataset) # VISUALIZE MISSING DATA

### MEAN: AVERAGE VALUE ###
mean(Sepal.Length) # CALCULATE THE MEAN OF THE SEPAL LENGTH ATTRIBUTE
mean(Sepal.Width) # CALCULATE THE MEAN OF THE SEPAL WIDTH ATTRIBUTE
mean(Petal.Length) # CALCULATE THE MEAN OF THE PETAL LENGTH ATTRIBUTE
mean(Petal.Width) # CALCULATE THE MEAN OF THE PETAL WIDTH ATTRIBUTE

### MEDIAN: MIDDLE VALUE ###
median(Sepal.Length) # CALCULATE THE MEDIAN OF THE SEPAL LENGTH ATTRIBUTE
median(Sepal.Width) # CALCULATE THE MEDIAN OF THE SEPAL WIDTH ATTRIBUTE
median(Petal.Length) # CALCULATE THE MEDIAN OF THE PETAL LENGTH ATTRIBUTE
median(Petal.Width) # CALCULATE THE MEDIAN OF THE PETAL WIDTH ATTRIBUTE

### VARIANCE: SPREAD OF DATA ###
var(Sepal.Length) # CALCULATE THE VARIANCE OF THE SEPAL LENGTH ATTRIBUTE
var(Sepal.Width) # CALCULATE THE VARIANCE OF THE SEPAL WIDTH ATTRIBUTE
var(Petal.Length) # CALCULATE THE VARIANCE OF THE PETAL LENGTH ATTRIBUTE
var(Petal.Width) # CALCULATE THE VARIANCE OF THE PETAL WIDTH ATTRIBUTE

### STANDARD DEVIATION ###
sd(Sepal.Length) # CALCULATE THE STANDARD DEVIATION OF THE SEPAL LENGTH ATTRIBUTE
sd(Sepal.Width) # CALCULATE THE STANDARD DEVIATION OF THE SEPAL WIDTH ATTRIBUTE
sd(Petal.Length) # CALCULATE THE STANDARD DEVIATION OF THE PETAL LENGTH ATTRIBUTE
sd(Petal.Width) # CALCULATE THE STANDARD DEVIATION OF THE PETAL WIDTH ATTRIBUTE

### STATISTICAL SUMMARY ###
summary(dataset) # CALCULATE THE STATISTICAL SUMMARY OF THE DATASET

### ASYMMETRY ###
skewness(Sepal.Length) # CALCULATE THE SKEWNESS OF THE SEPAL LENGTH ATTRIBUTE (POSITIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LARGER THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS RIGHT-SKEWED; NEGATIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LESS THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS LEFT-SKEWED). SKEWNESS IS A MEASURE OF THE ASYMMETRY OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE ABOUT ITS MEAN; MEANING THAT IT MEASURES THE DEGREE OF DISTORTION FROM THE NORMAL DISTRIBUTION; IN OTHER WORDS, SKEWNESS TELLS YOU THE AMOUNT AND DIRECTION OF SKEW (LEFT OR RIGHT) IN A DATASET.
skewness(Sepal.Width) # CALCULATE THE SKEWNESS OF THE SEPAL WIDTH ATTRIBUTE (POSITIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LARGER THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS RIGHT-SKEWED; NEGATIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LESS THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS LEFT-SKEWED). SKEWNESS IS A MEASURE OF THE ASYMMETRY OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE ABOUT ITS MEAN; MEANING THAT IT MEASURES THE DEGREE OF DISTORTION FROM THE NORMAL DISTRIBUTION; IN OTHER WORDS, SKEWNESS TELLS YOU THE AMOUNT AND DIRECTION OF SKEW (LEFT OR RIGHT) IN A DATASET.
skewness(Petal.Length) # CALCULATE THE SKEWNESS OF THE PETAL LENGTH ATTRIBUTE (POSITIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LARGER THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS RIGHT-SKEWED; NEGATIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LESS THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS LEFT-SKEWED). SKEWNESS IS A MEASURE OF THE ASYMMETRY OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE ABOUT ITS MEAN; MEANING THAT IT MEASURES THE DEGREE OF DISTORTION FROM THE NORMAL DISTRIBUTION; IN OTHER WORDS, SKEWNESS TELLS YOU THE AMOUNT AND DIRECTION OF SKEW (LEFT OR RIGHT) IN A DATASET.
skewness(Petal.Width) # CALCULATE THE SKEWNESS OF THE PETAL WIDTH ATTRIBUTE (POSITIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LARGER THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS RIGHT-SKEWED; NEGATIVE SKEWNESS INDICATES THAT THE MEAN OF THE DATA VALUES IS LESS THAN THE MEDIAN, AND THE DATA DISTRIBUTION IS LEFT-SKEWED). SKEWNESS IS A MEASURE OF THE ASYMMETRY OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE ABOUT ITS MEAN; MEANING THAT IT MEASURES THE DEGREE OF DISTORTION FROM THE NORMAL DISTRIBUTION; IN OTHER WORDS, SKEWNESS TELLS YOU THE AMOUNT AND DIRECTION OF SKEW (LEFT OR RIGHT) IN A DATASET.

### KURTOSIS ###
kurtosis(Sepal.Length) # CALCULATE THE KURTOSIS OF THE SEPAL LENGTH ATTRIBUTE (IF THE KURTOSIS IS GREATER THAN 3, THEN THE DATASET HAS HEAVIER TAILS THAN A NORMAL DISTRIBUTION (MORE IN THE TAILS) (LEPTOKURTIC DISTRIBUTION); IF THE KURTOSIS IS EQUAL TO 3, THEN THE DATASET HAS HA NORMAL DISTRIBUTION; IF THE KURTOSIS IS LESS THAN 3, THEN THE DATASET HAS LIGHTER TAILS THAN A NORMAL DISTRIBUTION (LESS IN THE TAILS) (PLATYKURTIC DISTRIBUTION)); KURTOSIS IS A MEASURE OF THE "TAILEDNESS" OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE; IN OTHER WORDS, KURTOSIS TELLS YOU THE HEIGHT AND SHARPNESS OF THE CENTRAL PEAK, RELATIVELY TO THAT OF A STANDARD BELL CURVE.
kurtosis(Sepal.Width) # CALCULATE THE KURTOSIS OF THE SEPAL WIDTH ATTRIBUTE (IF THE KURTOSIS IS GREATER THAN 3, THEN THE DATASET HAS HEAVIER TAILS THAN A NORMAL DISTRIBUTION (MORE IN THE TAILS) (LEPTOKURTIC DISTRIBUTION); IF THE KURTOSIS IS EQUAL TO 3, THEN THE DATASET HAS HA NORMAL DISTRIBUTION; IF THE KURTOSIS IS LESS THAN 3, THEN THE DATASET HAS LIGHTER TAILS THAN A NORMAL DISTRIBUTION (LESS IN THE TAILS) (PLATYKURTIC DISTRIBUTION)); KURTOSIS IS A MEASURE OF THE "TAILEDNESS" OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE; IN OTHER WORDS, KURTOSIS TELLS YOU THE HEIGHT AND SHARPNESS OF THE CENTRAL PEAK, RELATIVELY TO THAT OF A STANDARD BELL CURVE.
kurtosis(Petal.Length) # CALCULATE THE KURTOSIS OF THE PETAL LENGTH ATTRIBUTE (IF THE KURTOSIS IS GREATER THAN 3, THEN THE DATASET HAS HEAVIER TAILS THAN A NORMAL DISTRIBUTION (MORE IN THE TAILS) (LEPTOKURTIC DISTRIBUTION); IF THE KURTOSIS IS EQUAL TO 3, THEN THE DATASET HAS HA NORMAL DISTRIBUTION; IF THE KURTOSIS IS LESS THAN 3, THEN THE DATASET HAS LIGHTER TAILS THAN A NORMAL DISTRIBUTION (LESS IN THE TAILS) (PLATYKURTIC DISTRIBUTION)); KURTOSIS IS A MEASURE OF THE "TAILEDNESS" OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE; IN OTHER WORDS, KURTOSIS TELLS YOU THE HEIGHT AND SHARPNESS OF THE CENTRAL PEAK, RELATIVELY TO THAT OF A STANDARD BELL CURVE.
kurtosis(Petal.Width) # CALCULATE THE KURTOSIS OF THE PETAL WIDTH ATTRIBUTE (IF THE KURTOSIS IS GREATER THAN 3, THEN THE DATASET HAS HEAVIER TAILS THAN A NORMAL DISTRIBUTION (MORE IN THE TAILS) (LEPTOKURTIC DISTRIBUTION); IF THE KURTOSIS IS EQUAL TO 3, THEN THE DATASET HAS HA NORMAL DISTRIBUTION; IF THE KURTOSIS IS LESS THAN 3, THEN THE DATASET HAS LIGHTER TAILS THAN A NORMAL DISTRIBUTION (LESS IN THE TAILS) (PLATYKURTIC DISTRIBUTION)); KURTOSIS IS A MEASURE OF THE "TAILEDNESS" OF THE PROBABILITY DISTRIBUTION OF A REAL-VALUED RANDOM VARIABLE; IN OTHER WORDS, KURTOSIS TELLS YOU THE HEIGHT AND SHARPNESS OF THE CENTRAL PEAK, RELATIVELY TO THAT OF A STANDARD BELL CURVE.

### FREQUENT SUB-INTERVAL TABLE ###
table(cut(Sepal.Length,3)) # FREQUENT SUB-INTERVAL TABLE OF THE SEPAL LENGTH VARIABLE: THE FREQUENT SUB-INTERVAL TABLE IS A TABLE THAT SHOWS THE NUMBER OF OBSERVATIONS THAT FALL INTO EACH OF SEVERAL NON-OVERLAPPING CATEGORIES; IT IS A SPECIAL CASE OF A HISTOGRAM DIVIDED INTO NON-OVERLAPPING INTERVALS; FREQUENT SUB-INTERVAL TABLES ARE USED TO SUMMARIZE CATEGORICAL, COUNT, OR CONTINUOUS DATA.
table(cut(Sepal.Width,3)) # FREQUENT SUB-INTERVAL TABLE OF THE SEPAL WIDTH VARIABLE: THE FREQUENT SUB-INTERVAL TABLE IS A TABLE THAT SHOWS THE NUMBER OF OBSERVATIONS THAT FALL INTO EACH OF SEVERAL NON-OVERLAPPING CATEGORIES; IT IS A SPECIAL CASE OF A HISTOGRAM DIVIDED INTO NON-OVERLAPPING INTERVALS; FREQUENT SUB-INTERVAL TABLES ARE USED TO SUMMARIZE CATEGORICAL, COUNT, OR CONTINUOUS DATA.
table(cut(Petal.Length,3)) # FREQUENT SUB-INTERVAL TABLE OF THE PETAL LENGTH VARIABLE: THE FREQUENT SUB-INTERVAL TABLE IS A TABLE THAT SHOWS THE NUMBER OF OBSERVATIONS THAT FALL INTO EACH OF SEVERAL NON-OVERLAPPING CATEGORIES; IT IS A SPECIAL CASE OF A HISTOGRAM DIVIDED INTO NON-OVERLAPPING INTERVALS; FREQUENT SUB-INTERVAL TABLES ARE USED TO SUMMARIZE CATEGORICAL, COUNT, OR CONTINUOUS DATA.
table(cut(Petal.Width,3)) # FREQUENT SUB-INTERVAL TABLE OF THE PETAL WIDTH VARIABLE: THE FREQUENT SUB-INTERVAL TABLE IS A TABLE THAT SHOWS THE NUMBER OF OBSERVATIONS THAT FALL INTO EACH OF SEVERAL NON-OVERLAPPING CATEGORIES; IT IS A SPECIAL CASE OF A HISTOGRAM DIVIDED INTO NON-OVERLAPPING INTERVALS; FREQUENT SUB-INTERVAL TABLES ARE USED TO SUMMARIZE CATEGORICAL, COUNT, OR CONTINUOUS DATA.

### THE PROPORTION OF THE VARIABLES BY SPECIES ###
prop.table(xtabs(Sepal.Length~Species)) # THE PROPORTION OF THE SEPAL LENGTH VARIABLE BY SPECIES
prop.table(xtabs(Sepal.Width~Species)) # THE PROPORTION OF THE SEPAL WIDTH VARIABLE BY SPECIES
prop.table(xtabs(Petal.Length~Species)) # THE PROPORTION OF THE PETAL LENGTH VARIABLE BY SPECIES
prop.table(xtabs(Petal.Width~Species)) # THE PROPORTION OF THE PETAL WIDTH VARIABLE BY SPECIES

################### DATA SUMMARY: GRAPHS ###################
### BARPLOTS ###
barplot(table(Sepal.Length),main="SEPAL LENGTH") # BARPLOT OF THE SEPAL LENGTH VARIABLE
barplot(table(Sepal.Width),main="SEPAL WIDTH") # BARPLOT OF THE SEPAL WIDTH VARIABLE
barplot(table(Petal.Length),main="PETAL LENGTH") # BARPLOT OF THE PETAL LENGTH VARIABLE
barplot(table(Petal.Width),main="PETAL WIDTH") # BARPLOT OF THE PETAL WIDTH VARIABLE

### HISTOGRAMS ###
# CREATE HISTOGRAM OF SEPAL LENGTH VARIABLE
hist(Sepal.Length,freq = F,xlab = "SEPAL LENGTH", main = "A HISTOGRAM OF THE SEPAL LENGTH VARIABLE")
lines(density(Sepal.Length),col=2,lwd=3) # ADDING THE DENSITY CURVE OVER THE POLT
# CREATE HISTOGRAM OF SEPAL WIDTH VARIABLE
hist(Sepal.Width,freq = F,xlab = "SEPAL WIDTH", main = "A HISTOGRAM OF THE SEPAL WIDTH VARIABLE")
lines(density(Sepal.Width),col=2,lwd=3) # ADDING THE DENSITY CURVE OVER THE POLT
# CREATE HISTOGRAM OF PETAL LENGTH VARIABLE
hist(Petal.Length,freq = F,xlab = "PETAL LENGTH", main = "A HISTOGRAM OF THE PETAL LENGTH VARIABLE")
lines(density(Petal.Length),col=2,lwd=3) # ADDING THE DENSITY CURVE OVER THE POLT
# CREATE HISTOGRAM OF PETAL WIDTH VARIABLE
hist(Petal.Width,freq = F,xlab = "PETAL WIDTH", main = "A HISTOGRAM OF THE PETAL WIDTH VARIABLE")
lines(density(Petal.Width),col=2,lwd=3) # ADDING THE DENSITY CURVE OVER THE POLT

# NOTICE THE SHAPE OF THE DATA, MOST ATTRIBUTES EXHIBIT A NORMAL DISTRIBUTION.
pie(table(Species), main = "PIE CHART OF THE SPECIES VARIABLE") # PIE CHART OF THE SPECIES VARIABLE

### BOXPLOTS ###
# COMPARE EACH VARIABLE WITH THE SPECIES VARIABLE
boxplot(Sepal.Length~Species, ylab = "SEPAL LENGTH", main = "A DISTRIBUTION OF SEPAL LENGTH FOR SPECIES VARIABLES") # BOXPLOT OF THE SEPAL LENGTH VARIABLE BY SPECIES
boxplot(Sepal.Width~Species, ylab = "SEPAL WIDTH", main = "A DISTRIBUTION OF SEPAL WIDTH FOR SPECIES VARIABLES") # BOXPLOT OF THE SEPAL WIDTH VARIABLE BY SPECIES
boxplot(Petal.Length~Species, ylab = "PETAL LENGTH", main = "A DISTRIBUTION OF PETAL LENGTH FOR SPECIES VARIABLES") # BOXPLOT OF THE PETAL LENGTH VARIABLE BY SPECIES
boxplot(Petal.Width~Species, ylab = "PETAL WIDTH", main = "A DISTRIBUTION OF PETAL WIDTH FOR SPECIES VARIABLES") # BOXPLOT OF THE PETAL WIDTH VARIABLE BY SPECIES
# FEATURE BOXPLOTS:
par(mfrow=c(1,4)) # SET THE PLOT TO 1 ROW AND 4 COLUMNS
for(i in 1:4) { # LOOP THROUGH THE FIRST 4 COLUMNS
  boxplot(x[,i], main=names(iris)[i]) # CREATE BOXPLOT FOR EACH COLUMN
} # END OF LOOP

### DENSITY PLOTS ###
scales <- list(x=list(relation="free"), y=list(relation="free")) # SET THE SCALES FOR THE PLOT: FREE SCALES
featurePlot(x=x, y=y, plot="density", scales=scales) # CREATE THE PLOT FOR THE DENSITY OF THE VARIABLES

# GET THE PLOT FOR NUMERIC COLUMNS:
pairs(iris[,1:4]) # CREATE THE PLOT FOR THE NUMERIC COLUMNS OF THE DATASET
featurePlot(x=x, y=y, plot="ellipse") # CREATE THE PLOT FOR THE ELLIPSE OF THE VARIABLES

# CHECK THE COVARIANCE AND CORRELATION BETWEEN VARIABLES
cov(dataset[ ,1:4]) # COVARIANCE MATRIX OF THE FIRST 4 COLUMNS; THE COVARIANCE IS A MEASURE OF THE JOINT VARIABILITY OF TWO RANDOM VARIABLES.
cor(dataset[ ,1:4]) # CORRELATION MATRIX OF THE FIRST 4 COLUMNS; THE CORRELATION IS A MEASURE OF THE LINEAR ASSOCIATION BETWEEN TWO RANDOM VARIABLES. (CORRELATION IS POSITIVE WHEN THE VALUES INCREASE TOGETHER (POSITIVE LINEAR CORRELATION); CORRELATION IS ~ ZERO WHEN THERE IS NO LINEAR ASSOCIATION BETWEEN VARIABLES; CORRELATION IN NEGATIVE WHEN THE VALUES DECREASES TOGETHER (NEGATIVE LINEAR CORRELATION).)

################### MACHINE LEARNING ALGORITHM EVALUATION ###################
# ALGORITHMS ASSESSED USING 10-FOLD CROSS VALIDATION. METRIC FOR ASSESSMENT IN THIS EXAMPLE IS ACCURACY.
control <- trainControl(method="cv", number=10) # SET THE CONTROL FOR THE TRAINING (10-FOLD CROSS VALIDATION)
metric <- "Accuracy" # SET THE METRIC FOR THE TRAINING (ACCURACY)

####################### TRAIN ##########################
### LINEAR DISCRIMINANT ANALYSIS ###
set.seed(7) # SET THE SEED FOR REPRODUCIBILITY OF THE RESULTS
fit.lda <- train(Species~., data=train, method="lda", metric=metric, trControl=control) # TRAIN THE MODEL USING THE LDA METHOD (LINEAR DISCRIMINANT ANALYSIS)

### CLASSIFICATION AND REGRESSION TREES ###
set.seed(7) # SET THE SEED FOR REPRODUCIBILITY OF THE RESULTS
fit.cart <- train(Species~., data=train, method="rpart", metric=metric, trControl=control) # TRAIN THE MODEL USING THE CART METHOD (CLASSIFICATION AND REGRESSION TREES)

### K-NEAREST NEIGHBORS ###
set.seed(7) # SET THE SEED FOR REPRODUCIBILITY OF THE RESULTS
fit.knn <- train(Species~., data=train, method="knn", metric=metric, trControl=control) # TRAIN THE MODEL USING THE KNN METHOD (K-NEAREST NEIGHBORS)

### SUPPORT VECTOR MACHINES ###
set.seed(7) # SET THE SEED FOR REPRODUCIBILITY OF THE RESULTS
fit.svm <- train(Species~., data=train, method="svmRadial", metric=metric, trControl=control) # TRAIN THE MODEL USING THE SVM METHOD (SUPPORT VECTOR MACHINES)

### RANDOM FOREST ###
set.seed(7) # SET THE SEED FOR REPRODUCIBILITY OF THE RESULTS
fit.rf <- train(Species~., data=train, method="rf", metric=metric, trControl=control) # TRAIN THE MODEL USING THE RF METHOD (RANDOM FOREST)

### SUMMARIZE THE RESULTS ###
results <- resamples(list(lda=fit.lda, cart=fit.cart, knn=fit.knn, svm=fit.svm, rf=fit.rf)) # CREATE A LIST OF THE RESULTS OF THE MODELS
summary(results) # SUMMARIZE THE RESULTS

####################### TEST ##########################
### EVALUATE EVERY MODEL ON TEST DATA ###
predictions.lda <- predict(fit.lda, test) # PREDICT THE TEST DATA USING THE LDA MODEL
confusionMatrix(predictions.lda, test$Species) # CREATE A CONFUSION MATRIX OF THE PREDICTIONS.LDA
predictions.cart <- predict(fit.cart, test) # PREDICT THE TEST DATA USING THE CART MODEL
confusionMatrix(predictions.cart, test$Species) # CREATE A CONFUSION MATRIX OF THE PREDICTIONS.CART
predictions.knn <- predict(fit.knn, test) # PREDICT THE TEST DATA USING THE KNN MODEL
confusionMatrix(predictions.knn, test$Species) # CREATE A CONFUSION MATRIX OF THE PREDICTIONS.KNN
predictions.svm <- predict(fit.svm, test) # PREDICT THE TEST DATA USING THE SVM MODEL
confusionMatrix(predictions.svm, test$Species) # CREATE A CONFUSION MATRIX OF THE PREDICTIONS.SVM
predictions.rf <- predict(fit.rf, test) # PREDICT THE TEST DATA USING THE RF MODEL
confusionMatrix(predictions.rf, test$Species) # CREATE A CONFUSION MATRIX OF THE PREDICTIONS.RF