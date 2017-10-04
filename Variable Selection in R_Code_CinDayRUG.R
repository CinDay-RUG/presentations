#Recursive Feature Elimination Example
library(caret)
opack.data <- read.table(file.choose(), header = T, na.strings = ".")
caret.y <- opack.data[,3]
caret.x <- opack.data[,4:34]
subsets <- c(1:10, 15, 20, 25, 30)
set.seed(89)
ctrl <- rfeControl(functions = lmFuncs, method = "cv", verbose = F, returnResamp = "final")
profile <- rfe(caret.x, caret.y, sizes = subsets, rfeControl = ctrl)
profile
predictors(profile)
profile$fit
profile$resample
plot(profile, type = "l")
plot(profile, metric = "Rsquared", type = "l")

#Bayesian Model Averaging Example (with BMA)
library(BMA)
bma.y <- opack.data[,3]
bma.x <- opack.data[,4:34]
opack.bma <- bicreg(bma.x, bma.y, strict = FALSE, OR = 20, maxCol = 32, nbest = 10)
summary(opack.bma)
opack.bma$postprob
opack.bma$probne0
opack.bma$postmean
opack.bma$condpostmean
imageplot.bma(opack.bma)

#Bayesian Model Averaging Example (with BMS)
