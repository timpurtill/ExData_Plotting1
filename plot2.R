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

##Create the line graph of Global Active Power for each recorded time observation
png("plot2.png")
plot(x = reducedDataSet$dateTime, y = reducedDataSet$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(x = reducedDataSet$dateTime, y = reducedDataSet$Global_active_power)
dev.off()



