library(ggplot2)
qplot(cut, data = diamonds, geom = "bar")

qplot(price, data = diamonds, geom = "histogram", binwidth = 10)
qplot(price, data = diamonds, geom = "histogram", binwidth = 500)
qplot(price, data = diamonds, geom = "histogram", binwidth = 1000)

png("rGraph%d.png", 600, 400)
jpeg("rGraph%d.jpg", 600, 400)
pdf("rGraph.pdf", 600, 400)
dev.off()
ggsave("rGraph.png", 600, 400)


# scatter plot is the default for 2 variables
qplot(carat, price, data = diamonds)
qplot(log(carat), log(price), data = diamonds)
qplot(carat, price/carat, data = diamonds)

qplot(carat, price, data = diamonds, geom = c("point", "smooth"), method = lm, ylim = c(0, 20000))
qplot(carat, price, data = diamonds, ylim = c(0, 20000)) + geom_smooth(method = lm)

# We do not need to ignore the other variables when looking at scatterplots.
# We can map other variables to colour, shape, and size.
qplot(carat, price, data = diamonds, colour = color)
qplot(carat, price, data = diamonds, shape = cut)

# Facets allow us to display plots for different
subsets.
# facets = row variables ~ column variables
# (use ‘.’ for none or blank for wrapping)
qplot(carat, price, data = diamonds, facets = . ~ color)
qplot(carat, price, data = diamonds, facets = clarity ~ .)