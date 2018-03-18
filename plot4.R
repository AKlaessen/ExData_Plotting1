
# This script follows a step-by-step procedure to construct plot4.png for the Exploratory Data Project (week 1)
# of the Data Science Course. This assignment uses data from the UC Irvine Machine Learning Repository, 
# a popular repository for machine learning datasets. 
# In particular, the "Individual household electric power consumption Data Set" is used.
# This script is divided into sections with accompanying information. 


# Check if data is downloaded and extracted.
# If this is not the case, download data set and unzip 

folder <-"./Data"

if (!file.exists(folder)) {
  dir.create("./Data") 
  dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
  download.file(dataUrl, destfile="./Data/Datafile.zip") 
  unzip(zipfile="./Data/Datafile.zip", exdir="./Data") 
} 

# Read the file into an R dataframe. Data is about 130 MB, memory needed of at least 0,5 GB.

consumptionData     <- read.table(file= "./Data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?") 

# Convert Date and Time variables to Date/TIme classes in R

dateTime = paste(consumptionData$Date, consumptionData$Time, sep=",")
dateTime <-strptime(dateTime, format="%d/%m/%Y, %H:%M:%S")

consumptionData <- cbind(dateTime,consumptionData[,c(3,4,5,6,7,8,9)])

# Create a subset which only shows data from 2007-02-01 to 2007-02-02

startDate <- "2007-02-01 01:00:00"
endDate   <- "2007-02-02 23:59:00"

analysedData <- subset(consumptionData, dateTime >= as.POSIXct(startDate) & dateTime <= as.POSIXct(endDate))

# There is no NA value in this subset, so no further cleaning required

# Create plot4 in a png file

library(datasets)

png("plot4.png", width=480,height=480)

par(mfrow = c(2,2))   # create a 2x2 subplot

plot(analysedData$Global_active_power ~ analysedData$dateTime, type= "l", ylab ="Global Active Power", xlab="")

plot(analysedData$Voltage ~ analysedData$dateTime, type= "l", ylab ="Voltage", xlab="datetime")

plot(analysedData$Sub_metering_1 ~ analysedData$dateTime, type= "l", ylab ="Energy sub metering", xlab="")
lines(analysedData$Sub_metering_2 ~ analysedData$dateTime , type= "l", col="red")
lines(analysedData$Sub_metering_3 ~ analysedData$dateTime , type= "l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red", "blue"), lty=1, cex=0.8, bty = "n")

plot(analysedData$Global_reactive_power ~ analysedData$dateTime, type= "l", ylab ="Global_reactive_power", xlab="datetime")


# Copy the result from above to plot1.png

dev.off()
