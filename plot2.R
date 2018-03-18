
# This script follows a step-by-step procedure to construct plot2.png for the Exploratory Data Project (week 1)
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

# Create plot2 on screen

plot(analysedData$Global_active_power ~ analysedData$dateTime, type= "l", ylab ="Global Active Power (kilowatts)", xlab="")

# Copy the result from above to plot1.png

library(datasets)

dev.copy(png, file = "plot2.png", width=480,height=480)
dev.off()
