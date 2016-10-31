# build a leaf classification model

library(readr)
library( caret )
library( rattle )

data <- read_csv( "train.csv" )
trainIx <- createDataPartition( y=data$species, p=.8, list=FALSE )

trainData <- data[trainIx,]
testData <- data[-trainIx,]

print( sprintf("Train data observations: %d", nrow( trainData )))
print( sprintf("Test data observations: %d", nrow( testData )))

# remove ID colum
trainData <- trainData[,-1]
testData <- testData[,-1]
 
print( "Building a random forest model..." )
model <- train( species ~ ., method="rpart", data=trainData )

print( model$finalModel )
#plot( model$finalModel, uniform=TRUE, main="Classification Tree" )
#text( model$finalModel, use.n=TRUE, all=TRUE, cex=.8 )

classPredict <- predict( model, newdata=testData )

classResults <- testData$species == classPredict
correct = sum( classResults==TRUE )
incorrect = sum( classResults==FALSE )

print( sprintf( "Correct predictions: %d", correct ))
print( sprintf( "Incorect predictions: %d", incorrect ))
print( sprintf( "Percent correct: %2.2f", correct/(correct+incorrect)))

