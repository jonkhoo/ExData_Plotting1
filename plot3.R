library(datasets)

# Function to read the data from file
# Filters out 1/2/2007 and 2/2/2007
# Convert Date field to Date format
# Convert Time field to DateTime in POSIXct format
# Return a data frame object
read_data <- function() {
  tbl <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE, na.strings="?")
  tbl <- subset(tbl, tbl$Date=="1/2/2007" | tbl$Date=="2/2/2007")
  tbl$Time <- strptime(paste(tbl$Date,tbl$Time),format = "%d/%m/%Y %H:%M:%S", tz = "")
  tbl$Time <- as.POSIXct(tbl$Time)
  tbl$Date <- as.Date(tbl$Date,"%d/%m/%Y")
  
  return(tbl)  
}

# Read in relevant data into data frame
data <- read_data()

# Plot the graph
png("plot3.png", bg="white", width=480, height=480)

plot(data$Time, data$Sub_metering_1, type= "l", col="black", ylab= "Energy sub metering", xlab="")
lines(data$Time, data$Sub_metering_2, type="l", col="red")
lines(data$Time, data$Sub_metering_3, type="l", col="blue")

# Must specify line type (lty) or line width (lwd) for legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))

dev.off()

