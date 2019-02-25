getwd()
setwd("C:\\Users\\user\\Desktop\\a\\Applied Family of Functions\\Weather Data")

#read data

Chicago <- read.csv("Chicago-F.csv", row.names = 1,na.strings=c(""))#(row.names = 1)take row name from first column
Houston <- read.csv("Houston-F.csv", row.names = 1,na.strings=c(""))#(row.names = 1)take row name from first column

NewYork <- read.csv("NewYork-F.csv", row.names = 1,na.strings=c(""))#(row.names = 1)take row name from first column

SanFrancisco <- read.csv("SanFrancisco-F.csv", row.names = 1,na.strings=c(""))#(row.names = 1)take row name from first column


#IS THEY ARE DATA FRAME
is.data.frame(Chicago)
#we dont need data frame because all elementant are same, they are numeric so no real need for data frame 
#so lets convery into matrix
Chicago <- as.matrix(Chicago)
Houston <- as.matrix(Houston)
NewYork <- as.matrix(NewYork)
SanFrancisco <- as.matrix(SanFrancisco)

# check 
is.matrix(Chicago)
#lets put all in list
weather <- list(Chicago,NewYork,Houston,SanFrancisco)
weather#list is not having proper name so create name so you can access using $ sign
weather <- list(Chicago=Chicago,NewYork=NewYork,Houston=Houston,SanFrancisco=SanFrancisco)
weather
weather[3]#only element of list
weather[[3]]# final matrix
weather$Houston


#------use apply
?apply
apply(Chicago,1,mean)

# analysis one city
Chicago
apply(Chicago, 1,max)
apply(Chicago, 2, max)
# compare
apply(Chicago, 1,max)
apply(Houston, 1,max)
apply(NewYork, 1,max)
apply(SanFrancisco, 1,max)

# recreating the apply function with loop
Chicago
#1. via loop
output <- NULL
for(i in 1:5) {
    output[i] <- mean(Chicago[i,])
}
output
names(output) <- rownames(Chicago)
output
# varify
apply(Chicago,1,mean)


#------lapply
?lapply#input is either list or vector
Chicago
t(Chicago)
weather
laaply(weather,t)# list(weather$Chicago,weather$houston,weather$newyork,weather$sanfrancisco)
# here weather is input list and t is transpose function
lapply(weather, rbind, NewRow=1:12)# add one row in all list
?rowMeans
rowMeans(Chicago) # identical to apply(Chicago,1,mean)
lapply(weather, rowMeans)
#rowmean
#colmean
#rowsums
#colSums


#-----combining lapply with []operator
weather
weather$Chicago[1,]#weather[[1]][1,1]
weather[[1]][1,1]
lapply(weather, "[",1,1)#"[" represent last equire breaket of above line
lapply(weather, "[", ,3)

#adding your onw functions




