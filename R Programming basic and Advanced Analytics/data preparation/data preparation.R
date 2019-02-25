getwd()
setwd("C:\\Users\\user\\Desktop\\a\\data preparation")
#fin <- read.csv("future 500.csv")
fin <- read.csv("Future 500.csv", na.strings=c(""))# replace all impty value with NA
fin
head(fin)
tail(fin)
str(fin)
names(fin)
summary(fin)

#factor is basically a categorical variable
# id and inception are integer but better recognised as factor
#---changing non factor to factor
fin$ID <-factor(fin$ID)
fin$Inception <-factor(fin$Inception)
str(fin)
#---FVT(factor variable trap)
a <- c("12","13","14")
a
typeof(a)
b<- as.numeric(a)
typeof(b)
# ----converting into numeric for factor
z<-factor(c("12","13","14"))
z# r seen as category
typeof(z)
y<- as.numeric(z)# you will pick up factorization value
y# factor trap(since they are label variable )
#----correct way
x<- as.numeric(as.character(z))# factor variable first convert into character then numeric
x
typeof(x)

# --FVT EXAMPLE
head(fin)
#fin$Profit <- factor(fin$Profit)#dangerous
str(fin)
head(fin)
#fin$profit <- as.numeric(fin$Profit)#dangerous

#sub() and gsub()
?sub
fin$Expenses <- gsub("Dollars", "", fin$Expenses)# replace Dollars 
fin$Expenses <- gsub(",", "", fin$Expenses)


fin$Revenue <- gsub("$","", fin$Revenue)# not working because $ sign is a special sign in R
fin$Revenue <- gsub("\\$","", fin$Revenue)# remove $ sign
head(fin)
fin$Revenue <-gsub(",","",fin$Revenue)
fin$Growth <- gsub("%","", fin$Growth)
str(fin)
head(fin)
# convert charactor into numeric
fin$Expenses <- as.numeric(fin$Expenses)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Growth <- as.numeric(fin$Growth)
summary(fin)


#----------- Removing NA value
?NA
head(fin,24)
complete.cases(fin)# is there NA in any column rowwise
fin[!complete.cases(fin),]
fin <- read.csv("Future 500.csv", na.strings=c(""))# replace all impty value with NA
head(fin,20)# some of them are <NA> because all factor value have <NA. and other have NA
str(fin)

#========================filtering
#----FILTER: USING WHICH()FOR NON-MISSING DATA
head(fin)
fin[fin$Revenue == 9746272,]# comparing revenue with missing value
which(fin$Revenue==9746272)# only represent correct row,,
fin[which(fin$Revenue==9746272),]#fin[3,]

#---------usig is.na() for missing value
head(fin,25)# all row have NA value
fin[fin$Expenses == NA,]

?is.na()# check something have NA value(logical)
fin[is.na(fin$Expenses),]
summary(fin)


#--------removing record of missing data
fin[!complete.cases(fin),]#all row have empty value
fin[is.na(fin$Industry),]
fin[!is.na(fin$Industry),]

#replacing missing data: factual analysis
fin[!complete.cases(fin),]
fin[is.na(fin$State),]
fin[is.na(fin$State)& fin$City == "New York", "State"]<- "NY"
fin[!complete.cases(fin),]
fin[c(11,377),]

fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "San Francisco", "State"]<- "CA"
fin[c(82,265),]

#replacing missing data: MEDIAN Iimputation method
fin[!complete.cases(fin),]
med_empl_retail <- median(fin[fin$Industry== "Retail", "Employees"], na.rm = TRUE)# ignore all NA value(na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Retail", "Employees"]<- med_empl_retail
fin[3,]

med_empl_finserv <- median(fin[fin$Industry== "Financial Services", "Employees"], na.rm = TRUE)
fin[is.na(fin$Employees) & fin$Industry == "Financial Services", "Employees"]<-med_empl_finserv
fin[330,]
#growth
fin[!complete.cases(fin),]
med_growth_constr <- median(fin[fin$Industry== "Construction", "Growth"], na.rm = TRUE)
med_growth_constr
fin[is.na(fin$Growth) & fin$Industry == "Construction", "Growth"] <- med_growth_constr
#revenue
fin[!complete.cases(fin),]
med_rev_constr <- median(fin[fin$Industry== "Construction", "Revenue"], na.rm = TRUE)
med_rev_constr
fin[is.na(fin$Revenue) & fin$Industry == "Construction", "Revenue"] <- med_rev_constr
#expenses
fin[!complete.cases(fin),]
med_exp_constr <- median(fin[fin$Industry== "Construction", "Expenses"], na.rm = TRUE)
med_exp_constr
fin[is.na(fin$Expenses) & fin$Industry == "Construction" & is.na(fin$Profit),"Expenses"] <- med_exp_constr

#replacing missing data:deriving value
fin[is.na(fin$Profit),]
fin[is.na(fin$Profit), "Profit"] <- fin[is.na(fin$Profit), "Revenue"]  - fin[is.na(fin$Profit), "Expenses"]


fin[is.na(fin$Expenses), "Expenses"] <- fin[is.na(fin$Expenses), "Revenue"]  - fin[is.na(fin$Expenses), "Profit"]
fin[!complete.cases(fin),]


#--------------visulization
install.packages("ggplot2")
library(ggplot2)

p<- ggplot(data = fin)
p+geom_point(aes(x=Revenue, y=Expenses,  colour =Industry, size=Profit))

#industry trend for expenses
d<-ggplot(data=fin, aes(x=Revenue, y=Expenses, colour=Industry))
d+geom_point()+
  geom_smooth(fill=NA, size=1.2)


#boxplot
f<- ggplot(data=fin, aes(x=Industry, y=Growth, colour= Industry))
f+geom_boxplot(size=1)
f+geom_jitter()+
  geom_boxplot(size=1, alpha=0.5, outlier.color = NA)
