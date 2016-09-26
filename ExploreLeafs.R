# explore the leaf data

library(readr)

#data <- read.csv( "train.csv", header=TRUE )
data <- read_csv( "train.csv" )
ncol( data )
nrow( data )
summary( data )
str( data )
