## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load dplyr package
library(dplyr)

# filter the data with Baltimore
filterbybalt <- filter(NEI, fips=="24510")
totalbyyearbalt <- with(filterbybalt, tapply(Emissions, year, sum))


# set the output device to PNG
png("plot2.png", width = 480, height = 480)

# plot year and the total emmission
plot(names(totalbyyearbalt), totalbyyearbalt,
     xlab = "year",
     ylab="Total Emission in a year (Ton)",
     main="Total Emission in Baltimore decreased from 1999 to 2008",
     type="b")

# output png
dev.off()

