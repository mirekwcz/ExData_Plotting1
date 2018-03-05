plot2 <- function()
{
    ## Function description: 
    ## 1. read data from household_power_consumption.txt file
    ## 2. extract/subset data for a period of 2 days: 2007-02-01 --- 2007-02-02
    ## 3. generate a plot of global active power vs. days 
    ## -------------- 
    ## The data file household_power_consumption.txt must be present in the working dir.
     
    ## read data into memory
    imported_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
    ## create column in table with date and time merged together
    date_time <- strptime(paste(imported_data$Date, imported_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    imported_data <- cbind(imported_data, date_time)
    ## change class of columns to appropriate class
    imported_data$Date <- as.Date(imported_data$Date, format="%d/%m/%Y")
    imported_data$Time <- format(imported_data$Time, format="%H:%M:%S")
    imported_data$Global_active_power <- as.numeric(imported_data$Global_active_power)
    imported_data$Global_reactive_power <- as.numeric(imported_data$Global_reactive_power)
    imported_data$Voltage <- as.numeric(imported_data$Voltage)
    imported_data$Global_intensity <- as.numeric(imported_data$Global_intensity)
    imported_data$Sub_metering_1 <- as.numeric(imported_data$Sub_metering_1)
    imported_data$Sub_metering_2 <- as.numeric(imported_data$Sub_metering_2)
    imported_data$Sub_metering_3 <- as.numeric(imported_data$Sub_metering_3)
    ## extract/subset data for 2 days between 2007-02-01 and 2007-02-02
    subset_data <- subset(imported_data, Date == "2007-02-01" | Date =="2007-02-02")
    ## plot 'global active power' vs days
    png("plot2.png", width=480, height=480)
    with(subset_data, plot(date_time, Global_active_power, type="l", xlab="datetime [Days]", ylab="Global Active Power [kilowatts]"))
    dev.off()
}
