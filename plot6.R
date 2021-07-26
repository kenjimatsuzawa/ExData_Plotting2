## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load dplyr package
library(dplyr)
library(ggplot2)
library(reshape2)

# pick up mobile related SCC
mobileSCC <- SCC[SCC$SCC.Level.One=="Mobile Sources", "SCC"]

# filter the data with coal related
filterbybaltmobile <- filter(NEI, fips=="24510" & SCC %in% mobileSCC)
filterbylosmobile <- filter(NEI, fips=="06037" & SCC %in% mobileSCC)

# sum up by year
mobilebaltbyyear <- with(filterbybaltmobile, tapply(Emissions, year, sum))
mobilelosbyyear <- with(filterbylosmobile, tapply(Emissions, year, sum))

rng <- range(c(mobilebaltbyyear, mobilelosbyyear))

# set the output device to PNG
png("plot6.png", width = 480, height = 480)

# plot emission by year and the type (by differnet line)
plot(c(1999,2002,2005,2008), mobilebaltbyyear, type="p", col="blue", xlab="yaer", ylab="Total Emission in a year (Ton)", ylim=rng)
lines(c(1999,2002,2005,2008), mobilebaltbyyear, col="blue")
points(c(1999,2002,2005,2008), mobilelosbyyear, type="p", col="red")
lines(c(1999,2002,2005,2008), mobilelosbyyear, col="red")
legend("topright", legend=c("Baltimore","LosAngels"), col=c("blue","red"), lty=c(1,1))
title(main="Emission by Vehicle in 2 cities")

# output png
dev.off()
