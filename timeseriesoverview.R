### ts
require(graphics)

## Using July 1954 as start date:
gnp <- ts(cumsum(1 + round(rnorm(100), 2)),
          start = c(1954, 7), frequency = 12)
str(gnp)
plot(gnp) # using 'plot.ts' for time-series plot

### chron but only if someone is curious
dts <- dates(c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92"))
dts
str(dts)
# [1] 02/27/92 02/27/92 01/14/92 02/28/92 02/01/92
tms <- times(c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26"))
tms
str(tms)
# [1] 23:03:20 22:29:56 01:03:30 18:21:03 16:56:26
x <- chron(dates = dts, times = tms)x
str(x)

### POSIX
p1 <- Sys.time()
p1
str(p1)
p2 <- as.POSIXlt(p1)
p2
str(p2)

### Character format
txt1 <- "2012-11-12 22:35:12"
str(txt1)
s1 <- strptime(txt1, format="%Y-%m-%d %H:%M:%S")
s1
str(s1)

### zoo
### Random observations
z1.index <- ISOdatetime(2004, rep(1:2,5), sample(28,10), 0, 0, 0)
z1.data <- rnorm(10)
z1 <- zoo(z1.data, z1.index)
str(z1)

### With a sine wave
z2.index <- as.POSIXct(paste(2004, rep(1:2, 5), sample(1:28, 10), sep = "-"))
z2.data <- sin(2*1:10/pi)
z2 <- zoo(z2.data, z2.index)
str(z1)

### Random obs with a Date index
Z.index <- as.Date(sample(12450:12500, 10))
Z.data <- matrix(rnorm(30), ncol = 3)
colnames(Z.data) <- c("Aa", "Bb", "Cc")
Z <- zoo(Z.data, Z.index)

### Vectors print in horizontal style
z1
### Matrices in vertical style
Z
Z[1:3, 2:3]

### Default plot creates a panel for each series
plot(Z)
### But can also display all series in a single panel
plot(Z, plot.type = "single", col = 2:4)

rbind(z1[5:10], z1[2:3])
cbind(z1, z2)

### xts
data(sample_matrix)
class(sample_matrix)

str(sample_matrix)

matrix_xts <- as.xts(sample_matrix,dateFormat='Date')
str(matrix_xts)

df_xts <- as.xts(as.data.frame(sample_matrix), important='very important info!')
str(df_xts)

### Constructor
xts(1:10, Sys.Date()+1:10)

matrix_xts['2007-03']
matrix_xts['/2007-01-07']
first(matrix_xts,'1 week')
first(last(matrix_xts,'1 week'),'3 days')

### Access to the index
indexClass(matrix_xts)
indexClass(convertIndex(matrix_xts,'POSIXct'))

axTicksByTime(matrix_xts, ticks.on='months')
### Simple example of plotting
plot(matrix_xts[,1],major.ticks='months',minor.ticks=FALSE,main=NULL,col=3)

### Questions? Other examples?