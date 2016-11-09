# build a leaf classification model

library(readr)
library( caret )
library( rattle )

# Load the training data
leafData <- read_csv( "train.csv" )

# Partition the data
dataSplitIndex <- function( data, percentTrain ) {
  index <- createDataPartition( y=data, p=percent, list=FALSE )
  return( index )
}

dataFoldsIx <- function( data, numfolds ) {
  foldsIx <- createFolds( y=data, k = numFolds, list = TRUE, returnTrain = FALSE )
  return( foldsIx )
}

set.seed(253)
sampleSetIx <- function( data, numSets, percent ) {
  ssIx <- sample(1:3, size=nrow(data), replace=FALSE, prob=percent )
  return( ssIx )
}
#train <- data[ssIx==1,]
#test <- data[ssIx==2,]

trainIx <- dataSplitIndex( leafData$species, .7 )

trainData <- data[trainIx,]
testData <- data[-trainIx,]

print( sprintf("Train data observations: %d", nrow( trainData )))
print( sprintf("Test data observations: %d", nrow( testData )))

# remove ID colum
trainData <- trainData[,-1]
testData <- testData[,-1]
 
print( "Building a random forest model..." )
model <- train( species ~ ., method="rf", data=trainData )

print( model$finalModel )
#plot( model$finalModel, uniform=TRUE, main="Classification Tree" )
#text( model$finalModel, use.n=TRUE, all=TRUE, cex=.8 )

classPredict <- predict( model, newdata=testData )

classResults <- testData$species == classPredict
excorrect = sum( classResults==TRUE )
incorrect = sum( classResults==FALSE )

print( sprintf( "Correct predictions: %d", correct ))
print( sprintf( "Incorect predictions: %d", incorrect ))
print( sprintf( "Percent correct: %2.2f", correct/(correct+incorrect)))

