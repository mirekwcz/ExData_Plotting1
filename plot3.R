plot3 <- function()
{
    ## Function description: 
    ## 1. read data from household_power_consumption.txt file
    ## 2. extract/subset data 2 days between 2007-02-01 and 2007-02-02
    ## 3. generate plot of different submetering vs days 
    ## ------------- 
    ## The data file household_power_consumption.txt must be located in the working dir.
       
    ## import data
    imported_data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors = FALSE)
    ## Create column in the table with date and time merged together
    date_time <- strptime(paste(imported_data$Date, imported_data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    imported_data<- cbind(imported_data, date_time)
    ## modify class of columns to the correct one 
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
    ## plot global_active_power vs days 
    png("plot3.png", width=480, height=480)
    with(subset_data, plot(date_time, Sub_metering_1, type="l", xlab="datetime [Days]", ylab="Energy sub metering"))
    lines(subset_data$date_time, subset_data$Sub_metering_2, type="l", col= "red")
    lines(subset_data$date_time, subset_data$Sub_metering_3, type="l", col= "blue")
    legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))
    dev.off()
}
