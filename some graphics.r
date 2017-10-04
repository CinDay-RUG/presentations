
# a bunch of plotting options that can be set like font size, margins, etc
par()

#do simple plot
x<-rnorm(1:100)
y<-rnorm(1:100)
z<-rep(c("a","b"),50)


par(mfrow=c(1,1))
#simple scatterplot
plot(x,y)

#show updates vs original
par(mfrow=c(1,2))
#simple scatterplot
plot(x,y)

#add title, xaxis, yaxis labels and set limits
plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3))



par(mfrow=c(1,1))


#change the markers
plot(1,1,xlim=c(0,20),ylim=c(1,3),type="n",xlab="labelx",ylab="labely")
for(i in 1:20)
{
points(i,2,pch=i)
text(i,2.25,i)
}

#i like 16
par(mfrow=c(1,2))
#simple scatterplot
plot(x,y)

plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3),pch=16)


#i may want to see the codes possibly a treatment or trait
par(mfrow=c(1,2))
#simple scatterplot
plot(x,y)

plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3),pch=z)

#add a legend

legend(-3,3,list("a=male","b=female"),cex=.6)
col<-rep("NA",100)

#can do colors as well
for (i in 1:length(z))
	{
	if (z[i]=="a")
	col[i]="red"
	else
	col[i]="blue"
	}


#with colors
par(mfrow=c(1,2))
#simple scatterplot
plot(x,y)

plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3),pch=as.character(z),
col=as.character(col))

#add a legend

legend(-3,3,list("male","female"),cex=.6,col=c("red","blue"),pch=c("a","b"))

#### another approach with multi panels
data<- data.frame(as.numeric(x),as.numeric(y),as.character(z),as.character(col))
#data<-c(,list(as.numeric(x),as.numeric(y),z,col))
names(data)<-c("x","y","z","col")
par(mfrow=c(2,2))

#simple scatterplot
plot(x,y)

plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3),pch=z,col=col)

#add a legend

legend(-3,3,list("male","female"),cex=.6,col=c("red","blue"),pch=c("a","b"))

plot(data$x,data$y,xlab="X Label",ylab="Y label",main="This is for males",xlim=c(-3,3),ylim=c(-3,3),pch=as.character(data$z),col="blue",type="n")
#where are the points
points(data$x[data$z=="a"],data$y[data$z=="a"],pch=16)
abline(lm(data$y[data$z=="a"]~data$x[data$z=="a"]))

plot(data$x,data$y,xlab="X Label",ylab="Y label",main="This is for females",xlim=c(-3,3),ylim=c(-3,3),pch=as.character(data$z),col="blue",type="n")
#where are the points
#add all the points
points(data$x,data$y,col="gray",pch=16)

points(data$x[data$z=="b"],data$y[data$z=="b"],main="This is for Males",pch=16)




#add the line
abline(lm(data$y[data$z=="b"]~data$x[data$z=="b"]))


library(lattice)
xyplot(data$y~data$x|data$z,par.strip.text=list(cex=.7),layout=c(1,2),xlab="label x",ylab="label y",
strip = function(..., style,bg,fg,factor.levels) 
strip.default(..., style = 2,bg="white",fg="red",factor.levels))




#controlling the labels to be male and female

xyplot(data$y~data$x|data$z,par.strip.text=list(cex=.7),layout=c(1,2),xlab="label x",ylab="label y",
strip = function(..., style,bg,fg,factor.levels) 
strip.default(..., style = 2,bg="white",fg="red",factor.levels=c("Male","Female")))



#showing how to control layout
g<-matrix(c(1,1,1,2,3,4),nrow=3,ncol=2)
layout(g,heights=c(.3,.4,.4),widths=c(.4,.6))
layout.show(4)


#final plot

plot(x,y,xlab="X Label",ylab="Y label",main="This is a title",xlim=c(-3,3),ylim=c(-3,3),pch=z,col=col)

#add a legend

legend(-3,3,list("male","female"),cex=.6,col=c("red","blue"),pch=c("a","b"))

#original plot
plot(x,y)

plot(data$x,data$y,xlab="X Label",ylab="Y label",main="This is for males",xlim=c(-3,3),ylim=c(-3,3),pch=as.character(data$z),col="blue",type="n")
#where are the points
points(data$x[data$z=="a"],data$y[data$z=="a"],pch=16)
abline(lm(data$y[data$z=="a"]~data$x[data$z=="a"]))

plot(data$x,data$y,xlab="X Label",ylab="Y label",main="This is for females",xlim=c(-3,3),ylim=c(-3,3),pch=as.character(data$z),col="blue",type="n")
#where are the points
points(data$x[data$z=="b"],data$y[data$z=="b"],main="This is for Males",pch=16)

#add the line
abline(lm(data$y[data$z=="b"]~data$x[data$z=="b"]))
text(-2,1,"This is text")
?pdf

library (rgl)
# (3) Visualizing a simple DEM model

z <- 2 * volcano        # Exaggerate the relief
x <- 10 * (1:nrow(z))   # 10 meter spacing (S to N)
y <- 10 * (1:ncol(z))   # 10 meter spacing (E to W)

open3d()
bg3d("slategray")
material3d(col="black")
persp3d(x, y, z, col = "green3", aspect="iso",
      axes = FALSE, box = FALSE)

# (4) A cylindrical plot

z <- matrix(seq(0, 1, len=50), 50, 50)
theta <- t(z)
r <- 1 + exp( -pmin( (z - theta)^2, (z - theta - 1)^2, (z - theta + 1)^2 )/0.01 )
x <- r*cos(theta*2*pi)
y <- r*sin(theta*2*pi)

open3d()
persp3d(x, y, z, col="red")

# (5) A globe

lat <- matrix(seq(90,-90, len=50)*pi/180, 50, 50, byrow=TRUE)
long <- matrix(seq(-180, 180, len=50)*pi/180, 50, 50)

r <- 6378.1 # radius of Earth in km
x <- r*cos(lat)*cos(long)
y <- r*cos(lat)*sin(long)
z <- r*sin(lat)

open3d()
persp3d(x, y, z, col="white", 
       texture=system.file("textures/worldsmall.png",package="rgl"), 
       specular="black", axes=FALSE, box=FALSE, xlab="", ylab="", zlab="",
       normal_x=x, normal_y=y, normal_z=z)
play3d(spin3d(axis=c(0,0,1), rpm=8), duration=5)





library(car)


scatterplot.matrix(~income + education + prestige, 
    transform=FALSE,diagonal="histogram", data=Duncan)


library(R2PPT)
# installstatconnDCOM()



MyPres<-PPT.Init(visible=TRUE)
MyPres<-PPT.AddBlankSlide(MyPres)

scatterplot.matrix(~income + education + prestige, 
    transform=FALSE,diagonal="histogram", data=Duncan)

MyPres<-PPT.AddGraphicstoSlide(MyPres,size=c(10,10,700,500),dev.out.type="wmf")

MyPres<-PPT.AddBlankSlide(MyPres)
MyPres<-PPT.AddGraphicstoSlide(MyPres,size=c(10,10,70,50),dev.out.type="wmf")

MyPres<-PPT.AddGraphicstoSlide(MyPres,size=c(50,40,400,400),dev.out.type="wmf")
MyPres<-PPT.AddBlankSlide(MyPres)


MyPres<-PPT.AddTitleSlide(MyPres,title="Title Slide",subtitle="Subtitle here")
MyPres<-PPT.AddTitleOnlySlide(MyPres,title="Title Only",title.fontsize=40,title.font="Arial")
MyPres<-PPT.AddTextSlide(MyPres,title="Text Slide",text="Text1 \rText2 \rText3",text.font="Arial")



?windows()
windows(6,10)
library(TeachingDemos)
mat<-matrix( runif(18*10), nrow=10)
faces2(mat, main='Random Faces')



if(F)
{


ideas
general plot
layout
points
	markers, colors
lines
text 
mtext
axis to put labels
grayed out data
legend
multipanel


barplot
labels


boxplot
text below with saving coords

correlation plots
boxplots off diagonals

lattice plot
panel functions

ggplot??

rgl
map

face plot

R2PPT


}