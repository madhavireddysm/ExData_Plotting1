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

# Get data from the dates 2007-02-01 and 2007-02-02 only.

Data <- Dataset[Dataset$Date %in% c("1/2/2007","2/2/2007"),]

# Convert the Date and Time variables to Date/Time classes in R using the strptime function.

SetTime <-strptime(paste(Data$Date, Data$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
Data <- cbind(SetTime, Data)

# Plot4

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
colors <- c("black","red","blue")
par(mfrow=c(2,2))
plot(Data$SetTime, Data$Global_active_power, type="l", col=colors[1], xlab="", ylab="Global Active Power")

plot(Data$SetTime, Data$Voltage, type="l", col=colors[1], xlab="datetime", ylab="Voltage")

plot(Data$SetTime, Data$Sub_metering_1, type="l", col = colors[1], xla ="", ylab="Energy sub metering")
lines(Data$SetTime, Data$Sub_metering_2, col=colors[2])
lines(Data$SetTime, Data$Sub_metering_3, col=colors[3])
legend("topright", legend=labels, col=colors, bty="n", lty=1, lwd=c(1,1,1))

plot(Data$SetTime, Data$Global_reactive_power, type="l", col=colors[1], xlab="datetime", ylab="Global_reactive_power")

dev.copy(png,"./Programming_Assignment_1/plot4.png", width=480, height=480, units='px') 
dev.off()