# Download and unzip data file.

setwd("/Users/MadhaviReddy/ExploratoryDataAnalysis")

downloadURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
downloadFile <- './Programming_Assignment_1/household_power_consumption.zip'
downloadDir <- './Programming_Assignment_1'

if(!file.exists('Programming_Assignment_1'))
{  
  dir.create('Programming_Assignment_1')
  download.file(downloadURL, downloadFile)
  unzip(downloadFile, overwrite = T, exdir = downloadDir)
}  

# Read data from the input file where missing values are coded as "?"

InputFile <- file('./Programming_Assignment_1/household_power_consumption.txt')
Dataset <- read.table(InputFile, header=T, sep=";", na.strings="?")

# Get data from the dates 2007-02-01 & 2007-02-02 only.

Data <- Dataset[Dataset$Date %in% c("1/2/2007","2/2/2007"),]

# Convert the Date and Time variables to Date/Time classes in R using the strptime function.

SetTime <-strptime(paste(Data$Date, Data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
Data <- cbind(SetTime, Data)

# Plot1

hist(Data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"./Programming_Assignment_1/plot1.png", width=480, height=480, units='px') 
dev.off()
