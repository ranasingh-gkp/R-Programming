getwd()
setwd("C:\\Users\\Raftaar Singh\\Desktop\\check\\Lists")
#fin <- read.csv("future 500.csv")
util <- read.csv("machine utilization.csv", na.strings=c(""))# replace all impty value with NA
util
head(util)
tail(util)
str(util)
names(util)
summary(util)

#==========================
#FOLLOWING COMPONENT IN LIST
#CHARACTRISTICS :   machine name
#vector         :  (min,median,mode)
#logical            utilization below 90%
#vector         : all houur utilization is unknown(NA)
#dataframe      : FOR MACHINE
#plot           : ALL MACHINE
#==================================

#data utilization column
util$Utilization = 1- util$Percent.Idle

# handling date-time in R
?POSIXct
util$posixtime <- as.POSIXct(util$Timestamp, format = "%d/%m/%Y %H:%M")
head(util,12)
summary(util)
#rearrange columns in df
util$Timestamp <-NULL
util<- util[,c(4,1,2,3)]
head(util,12)


#list
RL1<- util[util$Machine=="RL1",]
summary(RL1)
RL1$Machine <- factor(RL1$Machine)

summary(RL1)
util_stat_rl1 <- c(min(RL1$Utilization, na.rm=T),mean(RL1$Utilization, na.rm=T),max(RL1$Utilization, na.rm=T))
which(RL1$Utilization <0.90)
length(which(RL1$Utilization <0.90))
util_under_90_flag <- length(which(RL1$Utilization <0.90))>0
util_under_90_flag

list_rl1 <- list( "RL1", util_stat_rl1, util_under_90_flag ) #create list
list_rl1
#renaming component of list
names(list_rl1)
names(list_rl1) <- c("machine", "states", "lowthreshold")
names(list_rl1)

#extracting component of list
#[]-always return list
#[[]]-always return actual object
#$ -same as [[]]
list_rl1
list_rl1[1]
list_rl1[[1]]
list_rl1$machine

list_rl1[2]
typeof(list_rl1)
#how  would you access  3rd element of vector states
list_rl1[[2]][3]
list_rl1$states[3]
#--addinng and deleting list component
list_rl1[4] <- "new information"
list_rl1$unknownhours <- RL1[is.na(RL1$Utilization), "posixtime"]
list_rl1

#---ADD DATAFRAME
list_rl1[4] <-NULL #NUMERATION GET SHIFTED
list_rl1$Data <-RL1
list_rl1
summary(list_rl1)


#subsetting list
list_rl1
list_rl1[[4]][1]#first value of 4 element
list_rl1$unknownhours[1]
list_rl1[1:3]#list contain 3 element
list_rl1[c(1,4)]
#double equire breaket are not for subsetting
#[] is for subsetting
#list_rl1[[1:3]]#error


#-----time series plot
install.packages("ggplot2")
library(ggplot2)
p<- ggplot(data=util)
p+geom_line(aes(x=posixtime, y=Utilization,colour= Machine ), size=1.2)+
  facet_grid(Machine~.)+
  geom_hline(yintercept = 0.90, colour="Grey", size=1.2, linetype=3)
myplot<-p+geom_line(aes(x=posixtime, y=Utilization,colour= Machine ), size=1.2)+
   facet_grid(Machine~.)+
   geom_hline(yintercept = 0.90, colour="Grey", size=1.2, linetype=3)


list_rl1$plot <- myplot# to store into list
list_rl1
summary(list_rl1)
str(list_rl1)
