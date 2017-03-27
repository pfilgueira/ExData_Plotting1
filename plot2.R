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

## Creates the plot plot2
plot(x = dataSubset$dateTime, y = dataSubset$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

## Saves the plot in the corresponding png file
if (file.exists("plot2.png")) {
        file.remove("plot2.png")
}
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
