## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load dplyr package
library(dplyr)
library(ggplot2)
library(reshape2)

# filter the data with Baltimore
filterbybalt <- filter(NEI, fips=="24510")
yeartypebalt <- with(filterbybalt, tapply(Emissions, list(type, year), sum))

# set the output device to PNG
png("plot3.png", width = 480, height = 480)

# plot emission by year and the type (by differnet line)
y <- melt(yeartypebalt)
names(y) <- c("type", "year", "Emission")
g <- ggplot(y, aes(x = year, y=Emission, color=type))
g <- g + geom_line()
g <- g + labs(title="Emission by type in Baltimore", y="Emission (ton)")
plot(g)

# output png
dev.off()

