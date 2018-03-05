plot4 <- function()
{
    ## Function description: 
    ## 1. read data from the household_power_consumption.txt file
    ## 2. extract data for the period of 2 days: 2007-02-01 -- 2007-02-02
    ## 3. generate 4 plots:
    ##    1. Global_active_power vs. days
    ##    2. Voltage vs. days
    ##    2. Energy sub metering vs days
    ##    3. Global_reactive_power vs days
    ## -----------        
    ## household_power_consumption.txt file must be in the working dir.
        
    ## import data
    imported_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE)
    ## insert column into the data table with date and time merged together
    date_time <- strptime(paste(imported_data$Date, imported_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    imported_data <- cbind(imported_data, date_time)
    ## change class of columns to the correct one 
    imported_data$Date <- as.Date(imported_data$Date, format="%d/%m/%Y")
    imported_data$Time <- format(imported_data$Time, format="%H:%M:%S")
    imported_data$Global_active_power <- as.numeric(imported_data$Global_active_power)
    imported_data$Global_reactive_power <- as.numeric(imported_data$Global_reactive_power)
    imported_data$Voltage <- as.numeric(imported_data$Voltage)
    imported_data$Global_intensity <- as.numeric(imported_data$Global_intensity)
    imported_data$Sub_metering_1 <- as.numeric(imported_data$Sub_metering_1)
    imported_data$Sub_metering_2 <- as.numeric(imported_data$Sub_metering_2)
    imported_data$Sub_metering_3 <- as.numeric(imported_data$Sub_metering_3)
    ## extract and subset data for a period of 2 days between 2007-02-01 and 2007-02-02
    subset_data <- subset(imported_data, Date == "2007-02-01" | Date =="2007-02-02")
    ## plot 4 graphs
    png("plot4.png", width=480, height=480)
    par(mfrow=c(2,2))
    with(subset_data, plot(date_time, Global_active_power, type="l", xlab="datetime [days]", ylab="Global Active Power"))
    with(subset_data, plot(date_time, Voltage, type = "l", xlab="datetime [days]", ylab="Voltage"))
    with(subset_data, plot(date_time, Sub_metering_1, type="l", xlab="datetime [days]", ylab="Energy sub metering"))
    lines(subset_data$date_time, subset_data$Sub_metering_2,type="l", col= "red")
    lines(subset_data$date_time, subset_data$Sub_metering_3,type="l", col= "blue")
    legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
    with(subset_data, plot(date_time, Global_reactive_power, type="l", xlab="datetime [days]", ylab="Global_reactive_power"))
    dev.off()
}
