#----------------data
getwd()
setwd("C:\\Users\\user\\Desktop\\a\\Advanced Visualization")
movies <- read.csv("2_page_s6_file_2 ")
movies <- read.csv(file.choose())
head(movies)
str(movies)
colnames(movies) <- c("film","genre", "criticrating", "audiencerating","budget", "year")
head(movies)
tail(movies)
str(movies)
summary(movies)
#since year is not number,, we will convert as factor

movies$year <- factor(movies$year)
str(movies)

#----------------Aesthetics
install.packages("ggplot2")
library(ggplot2)
ggplot(data=movies, aes(x=criticrating, y=audiencerating))+
  geom_point()

# add color
ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=Genre))+
  geom_point()
# size
ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=genre, size=budget))+
  geom_point()#size of bubble according to budget

#-------------------ploting with layers
p<- ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=genre,
                        size=budget))
p+geom_point()  
p+geom_line()
#multiple layer
p+geom_point() +geom_line()
p +geom_line()+geom_point()

#--overriding aesthetics
#aesthetics must be with some variable
q<- ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=genre,
                            size=budget))
q+geom_point(aes(size=criticrating))#ex1
q+geom_point(aes(colour=budget))
q+geom_point(aes(x=budget))+xlab("budget")
q+geom_line(size=1)+geom_point()
#-----------------mapping vs setting
r<- ggplot(data=movies, aes(x=criticrating, y=audiencerating))
r+geom_point()
#mapping
r+geom_point(aes(colour=genre))
#setting 
r+geom_point(colour="darkgreen")
#error====r+geom_point(aes(colour="genre"darkgreen))

#mapping
r+geom_point(aes(size=budget))
#setting
r+geom_point(size=10, colour="darkgreen")


#----------------histograam and density chart
s<- ggplot(data=movies, aes(x=budget))
s+geom_histogram(binwidth = 10)#32 movie have 0-10 million budget, 70 movie have 10.20 million budget
# add colour
s+geom_histogram(binwidth = 10, fill="green")#setting
s+geom_histogram(binwidth = 10, aes(fill=genre), colour="black")


#density chart
s+geom_density(aes(fill=genre), position = "stack")


#---------------starting layer tips
t<- ggplot(data=movies, aes(x=audiencerating))
t+geom_histogram(binwidth = 10, fill="white", colour="blue")
# another way
t=ggplot(data=movies)
t+geom_histogram(binwidth = 10,
                 aes(x=audiencerating),
                 fill="white", colour="blue")+
  xlab("audiencerating")

#criticrating histogram
t+geom_histogram(binwidth = 10,
                 aes(x=criticrating),
                 fill="white", colour="blue")+
  xlab("criticrating")


#---------------------statistical transformation
u<- ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=genre))
u+geom_point()+geom_smooth(fill=NA)

# boxplot
u<-ggplot(data=movies, aes(x=genre, y=audiencerating, colour=genre))
u+geom_boxplot(size=1.2)+geom_point()
u+geom_boxplot(size=1.2)+geom_jitter()
#another way
u+geom_jitter()+geom_boxplot(size=1.2, alpha=0.5)# alpha- tranparency


#----------------------using Facets
v<- ggplot(data = movies, aes(x=budget))
v+geom_histogram(binwidth = 10, aes(fill=genre), colour="black")
#facets
v+geom_histogram(binwidth = 10, aes(fill=genre), colour="black")+
  facet_grid(genre~.,scales = "free")
#scatter plot
w<-ggplot(data=movies, aes(x=criticrating, y=audiencerating, colour=genre))
w+geom_point(size=3)
#facets
w+geom_point(size=3)+
  facet_grid(genre~.)
w+geom_point(size=3)+
  facet_grid(.~year)

w+geom_point(size=3)+
  facet_grid(genre~year)

w+geom_point(aes(size=budget))+
  geom_smooth()+
  facet_grid(genre~year)#here limit is from -50 to 50 so make it correct , we will use cartisian method
#--------------------coordinate
#limits,zoom
m<-ggplot(data=movies, aes(x=criticrating, y=audiencerating, size=budget,colour=genre))
m+geom_point()+
  xlim(50,100)+
  ylim(50,100)

#zoom
n<-ggplot(data=movies, aes(x=budget))
n+geom_histogram(binwidth = 10, aes(fill=genre), colour="black")+
  coord_cartesian(ylim=c(0,50))

#improve above 
w+geom_point(aes(size=budget))+
  geom_smooth()+
  facet_grid(genre~year)+
  coord_cartesian(ylim=c(0,100))



#--------------theme
o<- ggplot(data=movies, aes(x=budget))
h<- o+geom_histogram(binwidth = 10, aes(fill=genre), colour="black")
#axes labels
h+xlab("money axis")+
  ylab("number of movies")+
  theme(axis.title.x = element_text(colour="darkgreen", size=30),
        axis.title.y = element_text(colour="red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20))
?theme

#legend
h+xlab("money axis")+
  ylab("number of movies")+
  ggtitle("movie budget distribution")+
  theme(axis.title.x = element_text(colour="darkgreen", size=30),
        axis.title.y = element_text(colour="red", size=30),
        axis.text.x = element_text(size=20),
        axis.text.y = element_text(size=20),
        legend.title = element_text(size = 30),
        legend.text = element_text(size = 20),
        legend.position = c(1,1),#top right corner
        legend.justification = c(1,1),
        plot.title=element_text(colour = "darkblue", size=40, family="courier"))
