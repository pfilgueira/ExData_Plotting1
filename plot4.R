# Exploratory Data Analysis - week 1 - Final Project

setwd("~pfilgueira/Dropbox/Pessoal/Especializacao/Data Science/Exploratory Data Analysis")

if (!file.exists("week1")) {
        dir.create("week1")
}
setwd("./week1")

## Download and Uncompress the File
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "household_power_consumption.zip"
download.file(url, destfile, method = "curl")
unzip(destfile)

## Deletes the Zip File
if (file.exists(destfile)) file.remove(destfile)

## Reads the dataset and subsets only the records required
data<-read.table("household_power_consumption.txt", header = TRUE, sep= ";", 
                 colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
dataSubset <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")

## Convert the date and time strings to date/time classes to be used later
dataSubset$dateTime <- paste(dataSubset$Date, dataSubset$Time)
dataSubset$dateTime <- strptime(dataSubset$dateTime, "%d/%m/%Y %H:%M:%S")

## Creates the plot plot4
colors <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

par(mfrow=c(2,2))

plot(x = dataSubset$dateTime, y = dataSubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", col="black")

plot(x = dataSubset$dateTime, y = dataSubset$Voltage, type = "l", xlab = "", ylab = "Voltage", col="black")

plot(x = dataSubset$dateTime, y = dataSubset$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering", col="black")
lines(dataSubset$dateTime, dataSubset$Sub_metering_2, col="red")
lines(dataSubset$dateTime, dataSubset$Sub_metering_3, col="blue")
legend("toprigth", bty = "n", legend = labels, lty = 1, col = colors)

plot(x = dataSubset$dateTime, y = dataSubset$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power", col="black")

## Saves the plot in the corresponding png file
if (file.exists("plot4.png")) {
        file.remove("plot4.png")
}
dev.copy(png,"plot4.png")
dev.off()
