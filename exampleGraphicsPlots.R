library(XML)
library(ggplot2) 
theurl <- "http://en.wikipedia.org/wiki/List_of_Crayola_crayon_colors"
html <- htmlParse(theurl)
crayola <- readHTMLTable(html, stringsAsFactors = FALSE)[[2]]
crayola <- crayola[, c("Hex Code", "Issued", "Retired")]
names(crayola) <- c("colour", "issued", "retired")
crayola <- crayola[!duplicated(crayola$colour),]
crayola$retired[crayola$retired == ""] <- 2011 

colours <- ddply(crayola, .(colour), transform, year = issued:retired) 

p <- ggplot(colours, aes(year, 1, fill = colour)) +
     geom_bar(width = 1, position = "fill", binwidth = 1) +
     theme_bw() + scale_fill_identity() 

p1 <- ggplot(colours, aes(year, 1, fill = colour)) +
     geom_area(position = "fill", colour = "white") +
     theme_bw() + scale_fill_identity() 

labels <- c(1903, 1949, 1958, 1972, 1990, 1998,  2010)
breaks <- labels - 1
x <- scale_x_continuous("", breaks = breaks, labels = labels, expand = c(0, 0))
y <- scale_y_continuous("", expand = c(0, 0))
ops <- opts(axis.text.y = theme_blank(), axis.ticks = theme_blank()) 

p + x + y + ops 
p1 + x + y + ops 

# Sort colors by HSV - not sure what this is really showing...
library(colorspace) 
sort.colours <- function(col) {
     c.rgb = col2rgb(col)
     c.RGB = RGB(t(c.rgb) %*% diag(rep(1/255, 3)))
     c.HSV = as(c.RGB, "HSV")@coords
     order(c.HSV[, 1], c.HSV[, 2], c.HSV[, 3])
 }
colours = ddply(colours, .(year), function(d) d[rev(sort.colours(d$colour)), ]) 
last_plot() %+% colours 


#
#  Doughnut (Consultants) Chart
#

# Set up dummy dataframe
DF <- data.frame(variable = 1:10, value = sample(10, replace = TRUE))

DF

#  Prepare the charts
library(ggplot2) 
DF <- data.frame(variable = 1:10, value = sample(10, replace = TRUE))
ggplot(DF, aes(factor(variable), value, fill = factor(variable))) + geom_bar(width = 1) 

last_plot() + scale_y_continuous(breaks = 0:10) +
    coord_polar() + labs(x = "", y = "") + opts(legend.position = "none",
    axis.text.x = theme_blank(), axis.text.y = theme_blank(),
    axis.ticks = theme_blank()) 

# Adding lines to chart areas
DF <- ddply(DF, .(variable), transform, border = rep(1, value))
head(DF, 10)

ggplot(DF, aes(factor(variable))) + geom_bar(width = 1,
     aes(y = value, fill = factor(variable))) +
     geom_bar(aes(y = border, width = 1), position = "stack",
         stat = "identity", fill = NA, colour = "white") +
     scale_y_continuous(breaks = 0:10) + coord_polar() +
     labs(x = "", y = "") + opts(legend.position = "none",
     axis.text.x = theme_blank(), axis.text.y = theme_blank(),
     axis.ticks = theme_blank()) 

