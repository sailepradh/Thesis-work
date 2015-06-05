## Getting gene list example 
oneName <- function() paste(sample(LETTERS,5,replace=TRUE),collapse="")
geneNames <- replicate(1000, oneName())
GroupA <- sample(geneNames, 400, replace=FALSE)
GroupB <- sample(geneNames, 750, replace=FALSE)
GroupC <- sample(geneNames, 250, replace=FALSE)
GroupD <- sample(geneNames, 300, replace=FALSE)
input  <-list(GroupA,GroupB,GroupC,GroupD)
input

GroupA.f <- geneNames %in% GroupA
GroupB.f <- geneNames %in% GroupB
GroupC.f <- geneNames %in% GroupC
GroupD.f <- geneNames %in% GroupD
input.df <- data.frame(A=GroupA.f,B=GroupB.f,C=GroupC.f,D=GroupD.f)
head(input.df)

### draw venn -diagram here

input.df <- data.frame(A=GroupA.f,B=GroupB.f,C=GroupC.f,D=GroupD.f)
test <- input.df*1
test$gene<-geneNames
test$count<-rowSums(test[-5])
test[which(test$count >=2),]$gene



