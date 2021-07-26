## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum up the Emmision by year
totalbyyear <- with(NEI, tapply(Emissions, year, sum))

png("plot1.png", width = 480, height = 480)

# plot year and the total emmission
plot(names(totalbyyear), totalbyyear,
     xlab = "year",
     ylab="Total Emission in a year (Ton)",
     main="Total Emission is decreasing from 1999 to 2008",
     type="b")

# output png
dev.off()
