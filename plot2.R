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
png("plot2.png", bg="white", width=480, height=480)
plot(data$Time, data$Global_active_power, type= "l", ylab= "Global Active Power (kilowatts)", xlab="")
dev.off()

