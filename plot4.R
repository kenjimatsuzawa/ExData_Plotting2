## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# load dplyr package
library(dplyr)
library(ggplot2)
library(reshape2)

# merge data
merged <- merge(NEI, SCC, by="SCC", all=T)

# filter the data with coal related
filterbycoal <- filter(merged, between(SCC, "10100101", "10100318"))

## coalbyyear <- data.frame(with(filterbycoal, tapply(Emissions, list(year, SCC.Level.Three), sum)))

coalbyyear <- with(filterbycoal, tapply(Emissions, year, sum))

# set the output device to PNG
png("plot4.png", width = 480, height = 480)

# plot emission by year and the type (by differnet line)
plot(names(coalbyyear), coalbyyear,
     xlab = "year",
     ylab="Total Emission in a year (Ton)",
     main="Total Emission by coal decreased from 1999 to 2008",
     type="b")

## comment out for the coal type
##y <- melt(coalbyyear)
##names(y) <- c("SCC", "year", "Emission")
##g <- ggplot(y, aes(x = year, y=Emission, color=SCC))
##g <- g + geom_line()
##g <- g + labs(title="Emission by type in Baltimore", y="Emission (ton)")
##plot(g)


# output png
dev.off()
