## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load dplyr package
library(dplyr)
library(ggplot2)
library(reshape2)

# merge data
merged <- merge(NEI, SCC, by="SCC", all=T)

# pick up mobile related SCC
mobileSCC <- SCC[SCC$SCC.Level.One=="Mobile Sources", "SCC"]

# filter the data with coal related
filterbybaltmobile <- filter(NEI, fips=="24510" & SCC %in% mobileSCC)

# sum up by year
mobilebaltbyyear <- with(filterbybaltmobile, tapply(Emissions, year, sum))

# set the output device to PNG
png("plot5.png", width = 480, height = 480)

# plot emission by year and the type (by differnet line)
plot(names(mobilebaltbyyear), mobilebaltbyyear,
     xlab = "year",
     ylab="Total Emission in a year (Ton)",
     main="Emission by mobile in Baltimore from 1999 to 2008",
     type="b")

# output png
dev.off()
