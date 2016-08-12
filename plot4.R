## Download and unzip the data files if not already present
if (length(dir(".", pattern = "^household_power_consumption.txt$", full.names = FALSE, ignore.case = TRUE))==0){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip", method = "curl")
        unzip("household_power_consumption.zip", exdir = ".")
}

##Only read in the records for "2007/2/1", and "2007/2/2"
hpcFileName <- "household_power_consumption.txt"
headerRow <- read.csv(hpcFileName, header = TRUE, nrow = 1, sep = ";")
nc <- ncol(headerRow)
hpcDate <- read.csv(hpcFilename, header = TRUE, as.is = TRUE, colClasses = c(NA, rep("NULL", nc - 1)), sep = ";")
startDateRow <- which.max(hpcDate$Date == "1/2/2007")
endDateRow <- which.max(hpcDate$Date == "3/2/2007")
startRow <- startDateRow - 1
reducedDataSet <- read.csv(hpcFileName, col.names = names(headerRow), skip = startRow, nrows = endDateRow - startDateRow, as.is = TRUE, sep = ";")

reducedDataSet$dateTime <- as.POSIXct(paste(reducedDataSet$Date,reducedDataSet$Time), format = "%d/%m/%Y %H:%M:%S", tz = "GMT")

##Create the four panel plot area
png("plot4.png")

par(mfcol = c(2, 2))

## Plot 2
plot(x = reducedDataSet$dateTime, y = reducedDataSet$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Global_active_power)

## Plot 3
plot(x = reducedDataSet$dateTime, y = reducedDataSet$Sub_metering_1, type = "n", xlab = "", ylab = "Energy Sub Metering")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Sub_metering_1, col = "black")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Sub_metering_2, col = "red")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Sub_metering_3, col = "blue")
legend("topright", names(reducedDataSet[,7:9]), lty = 1, col = c("black", "blue", "red"))

## Plot 4
plot(x = reducedDataSet$dateTime, y = reducedDataSet$Voltage, xlab = "datetime", ylab = "Voltage", type = "n")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Voltage)

## Plot 5
plot(x = reducedDataSet$dateTime, y = reducedDataSet$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power" ,type = "n")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Global_reactive_power)

dev.off()



